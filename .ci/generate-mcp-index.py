#!/usr/bin/env python3
"""
MCP Search Index Generator for REMnux Salt States

Parses .sls files with YAML-style frontmatter comments and generates a v3.0
search index for the REMnux tools documentation.

Usage:
    python3 generate-mcp-index.py [options]

Options:
    --states-dir=PATH       Path to salt-states repository (default: .)
    --output=PATH           Output JSON file path (default: search-index.json)
    --site-name=NAME        Site name (default: REMnux Documentation)
    --site-domain=DOMAIN    Site domain (default: docs.remnux.org)
    --site-description=DESC Site description
    --tool-prefix=PREFIX    Tool name prefix (default: remnux)

Environment Variables:
    STATES_DIR, OUTPUT_FILE, SITE_NAME, SITE_DOMAIN, SITE_DESCRIPTION, TOOL_PREFIX

Example:
    python generate-index.py --states-dir=/path/to/salt-states
"""
import argparse
import json
import os
import re
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Optional


@dataclass
class ToolInfo:
    """Parsed tool information from a salt state file."""
    name: str
    website: str
    description: str
    categories: list[str]
    author: str
    license: str
    notes: str = ""
    state_file_path: str = ""


def parse_front_matter(file_path: str) -> Optional[ToolInfo]:
    """
    Parse the front matter from a salt state file.

    Front matter format (YAML-style comments at the start of the file):
        # Name: tool-name
        # Website: https://example.com
        # Description: What this tool does
        # Category: Main Category: Subcategory
        # Author: Author Name
        # License: License Name
        # Notes: Optional usage notes

    Returns None if required fields are missing or if there's no category
    (internal dependencies don't have categories).
    """
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Extract comment lines at the beginning
    lines = content.split("\n")
    front_matter = {}

    for line in lines:
        if not line.startswith("#"):
            break

        # Parse "# Key: Value" format
        match = re.match(r"^#\s*(\w+):\s*(.*)$", line)
        if match:
            key = match.group(1).lower()
            value = match.group(2).strip()
            front_matter[key] = value

    # Check required fields
    required_fields = ["name", "website", "description", "author", "license"]
    if not all(f in front_matter for f in required_fields):
        return None

    # Parse categories (comma-separated)
    # Tools without categories are internal dependencies - skip them
    category_str = front_matter.get("category", "")
    categories = [c.strip() for c in category_str.split(",") if c.strip()]

    if not categories:
        return None  # Skip internal dependencies

    # Get relative path from salt-states root
    file_path_obj = Path(file_path)
    parts = file_path_obj.parts
    try:
        remnux_idx = parts.index("remnux")
        rel_path = "/".join(parts[remnux_idx:])
    except ValueError:
        rel_path = file_path_obj.name

    return ToolInfo(
        name=front_matter["name"],
        website=front_matter["website"],
        description=front_matter["description"],
        categories=categories,
        author=front_matter["author"],
        license=front_matter["license"],
        notes=front_matter.get("notes", ""),
        state_file_path=rel_path,
    )


def find_sls_files(states_dir: str) -> list[str]:
    """Find all .sls files in the remnux subdirectories."""
    sls_files = []
    remnux_dir = Path(states_dir) / "remnux"

    if not remnux_dir.exists():
        # Maybe we're already in the remnux dir
        remnux_dir = Path(states_dir)

    for sls_file in remnux_dir.rglob("*.sls"):
        # Skip init.sls files (typically just includes)
        if sls_file.name == "init.sls":
            continue
        sls_files.append(str(sls_file))

    return sls_files


def generate_index(
    states_dir: str,
    output_file: str,
    site_name: str,
    site_domain: str,
    site_description: str,
    tool_prefix: str,
) -> None:
    """Generate MCP search index from salt state files."""

    print(f"Scanning {states_dir} for .sls files...")
    sls_files = find_sls_files(states_dir)
    print(f"Found {len(sls_files)} .sls files")

    tools = []
    skipped = 0

    for sls_file in sls_files:
        try:
            tool = parse_front_matter(sls_file)
            if tool is None:
                skipped += 1
                continue

            # Create URL slug from tool name
            url_slug = tool.name.lower().replace(" ", "-").replace("_", "-")

            # Build full body content for search
            body_parts = [
                tool.description,
                "",
                f"Website: {tool.website}",
                f"Author: {tool.author}",
                f"License: {tool.license}",
                f"Categories: {', '.join(tool.categories)}",
            ]
            if tool.notes:
                body_parts.append(f"Notes: {tool.notes}")
            body_parts.append(f"State File: {tool.state_file_path}")

            tools.append({
                "url": f"/discover-the-tools/{url_slug}",
                "title": tool.name,
                "abstract": tool.description,
                "date": "",  # Salt states don't have dates
                "topics": tool.categories,
                "body": "\n".join(body_parts),
            })
        except Exception as e:
            print(f"  Warning: Error parsing {sls_file}: {e}")
            skipped += 1

    # Sort by name
    tools.sort(key=lambda t: t["title"].lower())

    # Build the index
    index = {
        "version": "3.0",
        "generated": datetime.now(timezone.utc).isoformat().replace("+00:00", "Z"),
        "site": {
            "name": site_name,
            "domain": site_domain,
        },
        "pageCount": len(tools),
        "pages": tools,
    }

    if site_description:
        index["site"]["description"] = site_description
    if tool_prefix:
        index["site"]["toolPrefix"] = tool_prefix

    # Ensure output directory exists
    output_path = Path(output_file)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    # Write output
    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(index, f, indent=2)

    print(f"Generated index with {len(tools)} tools ({skipped} skipped)")
    print(f"Output: {output_file}")


def main():
    parser = argparse.ArgumentParser(
        description="Generate MCP search index from REMnux salt states"
    )
    parser.add_argument(
        "--states-dir",
        default=os.environ.get("STATES_DIR", "."),
        help="Path to salt-states repository (default: current dir)",
    )
    parser.add_argument(
        "--output",
        default=os.environ.get("OUTPUT_FILE", "search-index.json"),
        help="Output JSON file path",
    )
    parser.add_argument(
        "--site-name",
        default=os.environ.get("SITE_NAME", "REMnux Documentation"),
        help="Site name for MCP branding",
    )
    parser.add_argument(
        "--site-domain",
        default=os.environ.get("SITE_DOMAIN", "docs.remnux.org"),
        help="Site domain",
    )
    parser.add_argument(
        "--site-description",
        default=os.environ.get(
            "SITE_DESCRIPTION",
            "Searchable documentation for REMnux malware analysis tools"
        ),
        help="Site description",
    )
    parser.add_argument(
        "--tool-prefix",
        default=os.environ.get("TOOL_PREFIX", "remnux"),
        help="Tool name prefix",
    )

    args = parser.parse_args()

    generate_index(
        states_dir=args.states_dir,
        output_file=args.output,
        site_name=args.site_name,
        site_domain=args.site_domain,
        site_description=args.site_description,
        tool_prefix=args.tool_prefix,
    )


if __name__ == "__main__":
    main()
