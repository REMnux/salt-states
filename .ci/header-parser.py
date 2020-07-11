#!/usr/bin/env python3
import re
import logging
import sys
import os
import requests
import json
import argparse

DEFAULT_REPO_URL = "https://github.com/REMnux/salt-states"
DEFAULT_PARENT_PATH = "discover-the-tools"  # used to find the page group
DEFAULT_VARIANTID = "master"
DEFAULT_SLS_SEARCH_PATH = os.path.dirname(os.path.realpath(__file__))

def env_or_required(key, help, default=None):
    if os.environ.get(key) or default:
        d = {'default': os.environ.get(key) or default}
    else:
        d = {'required': True}

    d["help"] = "ENV_VAR: {}\n".format(key) + \
    ("Default: {}\n".format(default) if default else "") + \
    help
    
    return d


parser = argparse.ArgumentParser(description='Parses headers and updates the gitbook.\nArguments can be provided via command line or environment variables.\nPrecendence: CMD > ENV > DEFAULT', formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('--gitbook-token', 
        **env_or_required("GITBOOK_TOKEN", help='Gitbook REST API Token'))
parser.add_argument('--gitbook-spaceid', 
        **env_or_required("GITBOOK_SPACEID", help='Gitbook Space UID.'))
parser.add_argument('--gitbook-variantid', 
        **env_or_required("GITBOOK_VARIANTID", default=DEFAULT_VARIANTID, help='Gitbook Variant ID.'))
parser.add_argument('--gitbook-parent-path', 
        **env_or_required("GITBOOK_PARENTPATH", default=DEFAULT_PARENT_PATH, help='Gitbook Parent Path. Used to find the page group'))
parser.add_argument('--repo-url', 
        **env_or_required("REPO_URL", default=DEFAULT_REPO_URL, help='Git repo URL. Used to create links to sls files.'))
parser.add_argument('--sls-search-path', 
        **env_or_required("SLS_SEARCH_PATH", default=DEFAULT_SLS_SEARCH_PATH, help='Base path to search for sls files recursively.'))

def get_logger():
    return logging.getLogger(__name__)


def set_logger():
    root = logging.getLogger(__name__)
    root.setLevel(logging.DEBUG)

    handler = logging.StreamHandler(sys.stderr)
    handler.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    root.addHandler(handler)
    return root


header_regex = re.compile(r"#\s*(?P<key>.*?):\s*(?P<value>.*)")

def parse_header(base_path, file_name, repo_url):
    file_path = os.path.join(base_path, file_name)
    fields = []
    name = None
    desc = ""
    categories = []
    with open(file_path) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("{%") or line.startswith("{{"): # can be empty line or template markup
                continue
            elif not line.startswith("#"):
                 break
            else:
                match = header_regex.match(line)
                if match:
                    key, value = match.group("key"), match.group("value").strip()
                    if key.lower() == "name":
                        name = value
                    elif key.lower() == "category":
                        if not value:
                            raise KeyError("categories field empty: %s" % file_path) 
                        for v in value.split(','):
                            if not v.strip():
                                continue  # there were empty category after comma for one case
                            full_cat = [vv.strip() for vv in v.split(':', 1)]
                            if len(full_cat) == 1:
                                full_cat.append("")
                            categories.append(full_cat)

                        if len(categories) >= 2:
                            get_logger().info(f"{name} has more than 1 categories: {value}")
                    elif key.lower() == "description":
                        desc = value
                    elif value: # ignore if empty
                        fields.append((key, value))
                else:
                    get_logger().warning("file: %s - line does not match with regex: %s" % (file_path, line))

    if not fields:
        raise KeyError("no header: %s" % file_path)
    elif not name:
        raise KeyError("found header but no name field: %s" % file_path)
    elif not categories:
        raise KeyError("found header but no categories: %s" % file_path)

    state_file_path = os.path.splitext(file_name)[0].strip('./').replace("/", ".")
    state_file_link = repo_url + '/blob/master/' + file_name # file_name is relative so it should work

    return {"name": name, "categories": categories, "fields": fields, "desc": desc, 
    "state_file": [state_file_path, state_file_link]}


def to_markdown(tool):
    header = "# {}\n".format(tool["name"])
    desc = (tool["desc"] + "\n\n") if tool["desc"] else ""
    markdown = []
    tmp = "**{}**: {}"
    # markdown.append(tmp.format("Categories", ",".join(tool["categories"])))
    for key, val in tool["fields"]:
        markdown.append(tmp.format(key,val))
    markdown.append("**State File**: [{}]({})".format(*tool["state_file"]))

    return header + desc + "  \n".join(markdown)


def update_page(cfg, page_url, content):
    url = "https://api-beta.gitbook.com/v1/spaces/{space_id}/content/v/{variant_id}/url/{parent_path}/{page_url}"

    DATA = {
        "document": {
            "transforms": [
                {
                    "transform": "replace",
                    "fragment": {
                        "markdown": content
                    }
                }
            ]
        }
    }

    try:
        resp = requests.post(
                url.format(space_id=cfg["space_id"], variant_id=cfg["variant_id"], parent_path=cfg["parent_path"], page_url=page_url),
                headers={"Authorization": "Bearer {}".format(cfg["token"]),
                         "Content-Type": "application/json"},
                json=DATA
                )
        get_logger().info("UPDATE %s RESP: %d, %s" % (page_url, resp.status_code, resp.content))
    except Exception as e:
        get_logger().exception(e)


def insert_page(cfg, title):
    page_url = re.sub(r"[^-a-z0-9.+_]", "+", title.lower())
    url = "https://api-beta.gitbook.com/v1/spaces/{space_id}/content/v/{variant_id}/url/{parent_path}"

    DATA = {
        "pages": [
            {
                "title": title,
                "description": cfg["parent_title"],
                "path": page_url,
                "document": "" # setting content here does not work.
            }
        ]
    }
    try:
        resp = requests.put(
                url.format(space_id=cfg["space_id"], variant_id=cfg["variant_id"], parent_path=cfg["parent_path"]),
                headers={"Authorization": "Bearer {}".format(cfg["token"]),
                         "Content-Type": "application/json"},
                json=DATA
                )
        get_logger().info("INSERT %s RESP: %d, %s" % (page_url, resp.status_code, resp.content))
    except Exception as e:
        get_logger().exception(e)

    return page_url


def get_gitbook_pages(cfg):
    url = "https://api-beta.gitbook.com/v1/spaces/{space_id}/content/v/{variant_id}/url/{parent_path}"

    try:
        resp = requests.get(
                url.format(space_id=cfg["space_id"], variant_id=cfg["variant_id"], parent_path=cfg["parent_path"]),
                headers={"Authorization": "Bearer {}".format(cfg["token"]),
                         "Content-Type": "application/json"}
                )
        get_logger().info("GET PAGES. RESP: %d" % (resp.status_code))
        if resp.status_code != 200:
            raise RuntimeError(f"Cannot get gitbook pages! Response status: {resp.status_code}")

        js = resp.json()
        d = {}
        for page in js["pages"]:
            title = page["title"]
            d[title] = {"": page["path"]}
            for subpage in page["pages"]:
                d[title][subpage["title"]] = subpage["path"]
        return d, js["title"]
    except Exception as e:
        get_logger().exception(e)
        raise

def find_tools(sls_search_path, repo_url):
    tools = {}
    for root, dirs, files in os.walk(sls_search_path, topdown=False):
        for file_name in files:
            if file_name.endswith(".sls"):
                rel_dir = os.path.relpath(root, sls_search_path)
                rel_file = os.path.join(rel_dir, file_name)
                try:
                    d = parse_header(sls_search_path, rel_file, repo_url)
                except KeyError as e:
                    get_logger().error(str(e))
                    continue

                for cat, subcat in d["categories"]:
                    tools.setdefault(cat, {})
                    tools[cat].setdefault(subcat, [])
                    tools[cat][subcat].append(d)

    return tools

def update_gitbook(cfg, tools, pages):
    for cat, subcat_d  in sorted(tools.items()):
        # check cat existence here
        if cat in pages:
            subpages = pages[cat]
        else:
            subpages = {"": insert_page(cfg, cat)}

        for subcat, tool_list in sorted(subcat_d.items()):
            content = "\n\n".join([to_markdown(d) for d in tool_list])
            
            if subcat != "":  # it is a subcategory. update config accordingly
                subcat_cfg = dict(cfg, parent_path=cfg["parent_path"]+"/"+subpages[''], parent_title=cat)
            else:
                subcat_cfg = cfg

            if subcat not in subpages: # page for this subcategory is not created yet. 
                subpages[subcat] = insert_page(subcat_cfg, subcat)

            update_page(subcat_cfg, subpages[subcat], content)


def main(args):
    set_logger()
    tools = find_tools(args.sls_search_path, args.repo_url)
    cfg = {
        "token": args.gitbook_token,
        "space_id": args.gitbook_spaceid,
        "variant_id": args.gitbook_variantid,
        "parent_path": args.gitbook_parent_path
    }
    pages, cfg["parent_title"] = get_gitbook_pages(cfg)
     
    update_gitbook(cfg, tools, pages)


if __name__ == "__main__":
    args = parser.parse_args()
    main(args)

