#!/usr/bin/env python3
"""
Audit REMnux documentation against SaltStack state files.

This script compares the tool entries in the documentation (https://github.com/REMnux/docs)
with the salt state files to find discrepancies.

Usage:
    # Run a full audit
    python audit-docs.py

    # Show only issues (skip informational messages)
    python audit-docs.py --issues-only

    # Check a specific state file
    python audit-docs.py --check remnux/tools/capa.sls

    # Output in JSON format
    python audit-docs.py --json

Environment Variables:
    GITHUB_ACCESS_TOKEN: GitHub personal access token (optional, uses SSH if not set)
    DOCS_REPO: Override default docs repository (optional, default: REMnux/docs)

Author: Generated for REMnux project
License: Same as REMnux project
"""

import argparse
import base64
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from dataclasses import dataclass, field
from pathlib import Path
from typing import Optional
from urllib.request import Request, urlopen
from urllib.error import HTTPError


# Default configuration
DEFAULT_DOCS_REPO = "REMnux/docs"
DEFAULT_DOCS_BRANCH = "master"
SALT_STATES_REPO = "REMnux/salt-states"


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


@dataclass
class DocToolInfo:
    """Tool information extracted from documentation."""
    name: str
    description: str
    website: str
    author: str
    license: str
    notes: str
    state_file_ref: str
    file_path: str
    category: str


@dataclass
class AuditIssue:
    """Represents an audit issue."""
    severity: str  # "error", "warning", "info"
    category: str  # "missing_from_docs", "missing_from_states", "mismatch", etc.
    tool_name: str
    message: str
    details: dict = field(default_factory=dict)


class GitHubAPI:
    """GitHub API client."""
    
    def __init__(self, token: str, repo: str, branch: str = "master"):
        self.token = token
        self.repo = repo
        self.branch = branch
        self.base_url = f"https://api.github.com/repos/{repo}"
    
    def _request(self, method: str, endpoint: str) -> dict:
        url = f"{self.base_url}{endpoint}"
        headers = {
            "Authorization": f"Bearer {self.token}",
            "Accept": "application/vnd.github.v3+json",
            "User-Agent": "REMnux-Docs-Auditor",
        }
        request = Request(url, headers=headers, method=method)
        try:
            with urlopen(request) as response:
                return json.loads(response.read().decode("utf-8"))
        except HTTPError as e:
            error_body = e.read().decode("utf-8") if e.fp else ""
            raise RuntimeError(f"GitHub API error {e.code}: {error_body}") from e
    
    def get_file_content(self, path: str) -> Optional[str]:
        try:
            file_data = self._request("GET", f"/contents/{path}?ref={self.branch}")
            return base64.b64decode(file_data["content"]).decode("utf-8")
        except RuntimeError as e:
            if "404" in str(e):
                return None
            raise
    
    def list_directory(self, path: str) -> list[str]:
        try:
            result = self._request("GET", f"/contents/{path}?ref={self.branch}")
            if isinstance(result, list):
                return [item["name"] for item in result]
            return []
        except RuntimeError:
            return []


class GitSSH:
    """Git client for SSH access."""
    
    def __init__(self, repo: str, branch: str = "master"):
        self.repo = repo
        self.branch = branch
        self.temp_dir = None
        self.repo_path = None
    
    def _run_git(self, *args, cwd=None) -> str:
        cmd = ["git"] + list(args)
        result = subprocess.run(cmd, cwd=cwd or self.repo_path, capture_output=True, text=True)
        if result.returncode != 0:
            raise RuntimeError(f"Git command failed: {' '.join(cmd)}\n{result.stderr}")
        return result.stdout
    
    def clone(self):
        self.temp_dir = tempfile.mkdtemp(prefix="remnux-docs-audit-")
        ssh_url = f"git@github.com:{self.repo}.git"
        print(f"Cloning {self.repo} via SSH...", file=sys.stderr)
        self._run_git("clone", "--branch", self.branch, "--depth", "1", ssh_url, self.temp_dir, cwd="/tmp")
        self.repo_path = self.temp_dir
    
    def get_file_content(self, path: str) -> Optional[str]:
        file_path = Path(self.repo_path) / path
        if not file_path.exists():
            return None
        return file_path.read_text()
    
    def list_directory(self, path: str) -> list[str]:
        dir_path = Path(self.repo_path) / path
        if not dir_path.exists():
            return []
        return [f.name for f in dir_path.iterdir()]
    
    def cleanup(self):
        if self.temp_dir and Path(self.temp_dir).exists():
            shutil.rmtree(self.temp_dir)


def parse_front_matter(file_path: str) -> Optional[ToolInfo]:
    """Parse the front matter from a salt state file."""
    try:
        with open(file_path, "r") as f:
            content = f.read()
    except Exception:
        return None
    
    lines = content.split("\n")
    front_matter = {}
    
    for line in lines:
        if not line.startswith("#"):
            break
        match = re.match(r"^#\s*(\w+):\s*(.*)$", line)
        if match:
            key = match.group(1).lower()
            value = match.group(2).strip()
            front_matter[key] = value
    
    # Check for required fields
    required = ["name", "website", "description", "author", "license"]
    if not all(f in front_matter for f in required):
        return None
    
    # Parse categories
    category_str = front_matter.get("category", "")
    categories = [c.strip() for c in category_str.split(",") if c.strip()]
    
    # Get relative path
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


def parse_doc_file(content: str, file_path: str) -> list[DocToolInfo]:
    """Parse a documentation markdown file to extract tool entries."""
    tools = []
    lines = content.split("\n")
    
    # Determine category from file path
    # e.g., "discover-the-tools/statically+analyze+code/pe-files.md" -> "Statically Analyze Code: PE Files"
    parts = file_path.replace("discover-the-tools/", "").replace(".md", "").split("/")
    if len(parts) == 1:
        category = parts[0].replace("+", " ").replace("-", " ").title()
    else:
        main_cat = parts[0].replace("+", " ").replace("-", " ").title()
        sub_cat = parts[1].replace("+", " ").replace("-", " ").title()
        category = f"{main_cat}: {sub_cat}"
    
    i = 0
    while i < len(lines):
        line = lines[i]
        
        # Look for tool headings (## ToolName or ## ToolName <a href...>)
        if line.startswith("## "):
            # Extract tool name, handling potential anchor links
            tool_name = line[3:].strip()
            # Remove anchor links like <a href="#numbers-to-string" id="numbers-to-string"></a>
            tool_name = re.sub(r'\s*<a\s+[^>]*>.*?</a>\s*$', '', tool_name).strip()
            
            # Skip non-tool headings
            if tool_name.lower() in ["overview", "introduction", "contents", ""]:
                i += 1
                continue
            
            # Parse tool entry
            description = ""
            website = ""
            author = ""
            license_info = ""
            notes = ""
            state_file_ref = ""
            
            i += 1
            while i < len(lines) and not lines[i].startswith("## "):
                entry_line = lines[i]
                
                if entry_line.strip() and not entry_line.startswith("**") and not entry_line.startswith("#"):
                    if not description:
                        description = entry_line.strip()
                elif entry_line.startswith("**Website**:"):
                    # Extract URL from markdown link
                    match = re.search(r'\[([^\]]+)\]', entry_line)
                    website = match.group(1) if match else entry_line.split(":", 1)[1].strip()
                elif entry_line.startswith("**Author**:"):
                    author = entry_line.split(":", 1)[1].strip().rstrip("\\")
                elif entry_line.startswith("**License**:"):
                    license_info = entry_line.split(":", 1)[1].strip().rstrip("\\")
                elif entry_line.startswith("**Notes**:"):
                    notes = entry_line.split(":", 1)[1].strip().rstrip("\\")
                elif entry_line.startswith("**State File**:"):
                    match = re.search(r'\[([^\]]+)\]', entry_line)
                    state_file_ref = match.group(1) if match else ""
                
                i += 1
            
            tools.append(DocToolInfo(
                name=tool_name,
                description=description,
                website=website,
                author=author,
                license=license_info,
                notes=notes,
                state_file_ref=state_file_ref,
                file_path=file_path,
                category=category,
            ))
        else:
            i += 1
    
    return tools


def find_all_state_files(base_path: str) -> list[str]:
    """Find all .sls files with front matter."""
    state_files = []
    for sls_file in Path(base_path).rglob("*.sls"):
        # Check if it has front matter
        try:
            with open(sls_file, "r") as f:
                # Read first few lines to find "# Name:"
                for _ in range(5):
                    line = f.readline()
                    if not line:
                        break
                    if line.strip().startswith("# Name:"):
                        state_files.append(str(sls_file))
                        break
                    if line.strip() and not line.strip().startswith("#"):
                        # Stop if we hit non-comment content (ignoring whitespace)
                        break
        except Exception:
            pass
    return state_files


def normalize_for_comparison(text: str) -> str:
    """Normalize text for comparison (lowercase, strip whitespace, remove markdown)."""
    # Remove markdown links
    text = re.sub(r'\[([^\]]+)\]\([^)]+\)', r'\1', text)
    # Remove backslashes (markdown line breaks)
    text = text.replace("\\", "")
    # Normalize whitespace
    text = " ".join(text.split())
    return text.lower().strip()


def audit_docs(
    state_files_base: str,
    backend,
    check_file: Optional[str] = None,
) -> list[AuditIssue]:
    """Run the audit and return a list of issues."""
    issues = []
    
    # Parse all state files
    print("Scanning state files...", file=sys.stderr)
    if check_file:
        state_files = [check_file] if os.path.isfile(check_file) else []
    else:
        state_files = find_all_state_files(state_files_base)
    
    state_tools = {}  # name -> ToolInfo
    for sf in state_files:
        tool = parse_front_matter(sf)
        if tool:
            state_tools[tool.name] = tool
    
    print(f"Found {len(state_tools)} tools in state files", file=sys.stderr)
    
    # Parse all documentation files
    print("Scanning documentation...", file=sys.stderr)
    doc_tools = {}  # name -> list[DocToolInfo]
    doc_categories = set()
    
    discover_tools = backend.list_directory("discover-the-tools")
    for item in discover_tools:
        if item.endswith(".md"):
            path = f"discover-the-tools/{item}"
            content = backend.get_file_content(path)
            if content:
                for doc_tool in parse_doc_file(content, path):
                    if doc_tool.name not in doc_tools:
                        doc_tools[doc_tool.name] = []
                    doc_tools[doc_tool.name].append(doc_tool)
                    doc_categories.add(doc_tool.category)
        else:
            # Subdirectory
            subdir_items = backend.list_directory(f"discover-the-tools/{item}")
            for subitem in subdir_items:
                if subitem.endswith(".md"):
                    path = f"discover-the-tools/{item}/{subitem}"
                    content = backend.get_file_content(path)
                    if content:
                        for doc_tool in parse_doc_file(content, path):
                            if doc_tool.name not in doc_tools:
                                doc_tools[doc_tool.name] = []
                            doc_tools[doc_tool.name].append(doc_tool)
                            doc_categories.add(doc_tool.category)
    
    print(f"Found {len(doc_tools)} tools in documentation", file=sys.stderr)
    
    # Audit 1: Tools with empty categories (informational)
    for name, tool in state_tools.items():
        if not tool.categories:
            issues.append(AuditIssue(
                severity="info",
                category="no_category",
                tool_name=name,
                message=f"Tool has no category (internal dependency, not documented)",
                details={"state_file": tool.state_file_path},
            ))
    
    # Audit 2: Tools missing from docs
    for name, tool in state_tools.items():
        if not tool.categories:
            continue  # Skip tools without categories
        
        if name not in doc_tools:
            # Case-insensitive check
            found = False
            for doc_name in doc_tools:
                if doc_name.lower() == name.lower():
                    found = True
                    issues.append(AuditIssue(
                        severity="warning",
                        category="name_case_mismatch",
                        tool_name=name,
                        message=f"Tool name case mismatch: state file has '{name}', docs have '{doc_name}'",
                        details={
                            "state_file": tool.state_file_path,
                            "doc_name": doc_name,
                        },
                    ))
                    break
            
            if not found:
                issues.append(AuditIssue(
                    severity="error",
                    category="missing_from_docs",
                    tool_name=name,
                    message=f"Tool is in state files but missing from documentation",
                    details={
                        "state_file": tool.state_file_path,
                        "expected_categories": tool.categories,
                    },
                ))
    
    # Audit 3: Tools in docs but missing from state files (orphaned)
    for name, doc_list in doc_tools.items():
        if name not in state_tools:
            # Case-insensitive check
            found = False
            for state_name in state_tools:
                if state_name.lower() == name.lower():
                    found = True
                    break
            
            if not found:
                issues.append(AuditIssue(
                    severity="warning",
                    category="missing_from_states",
                    tool_name=name,
                    message=f"Tool is in documentation but not found in state files",
                    details={
                        "doc_files": [d.file_path for d in doc_list],
                    },
                ))
    
    # Audit 4: Field mismatches
    for name, tool in state_tools.items():
        if name not in doc_tools:
            continue
        
        for doc_tool in doc_tools[name]:
            # Check description
            if normalize_for_comparison(tool.description) != normalize_for_comparison(doc_tool.description):
                issues.append(AuditIssue(
                    severity="warning",
                    category="description_mismatch",
                    tool_name=name,
                    message=f"Description mismatch",
                    details={
                        "state_file": tool.state_file_path,
                        "doc_file": doc_tool.file_path,
                        "state_value": tool.description,
                        "doc_value": doc_tool.description,
                    },
                ))
            
            # Check website
            state_website = normalize_for_comparison(tool.website)
            doc_website = normalize_for_comparison(doc_tool.website)
            if state_website != doc_website:
                issues.append(AuditIssue(
                    severity="warning",
                    category="website_mismatch",
                    tool_name=name,
                    message=f"Website mismatch",
                    details={
                        "state_file": tool.state_file_path,
                        "doc_file": doc_tool.file_path,
                        "state_value": tool.website,
                        "doc_value": doc_tool.website,
                    },
                ))
    
    # Audit 5: Category consistency check
    valid_categories = {
        "Examine Static Properties": ["General", "PE Files", "ELF Files", ".NET", "Go", "Deobfuscation"],
        "Statically Analyze Code": ["General", "Unpacking", "PE Files", "Python", "Scripts", "Java", ".NET", "Flash", "Android"],
        "Dynamically Reverse-Engineer Code": ["General", "Shellcode", "Scripts", "ELF Files"],
        "Perform Memory Forensics": [],
        "Explore Network Interactions": ["Monitoring", "Connecting", "Services"],
        "Investigate System Interactions": [],
        "Use Artificial Intelligence": [],
        "Analyze Documents": ["General", "PDF", "Microsoft Office", "Email Messages"],
        "Gather and Analyze Data": [],
        "View or Edit Files": [],
        "General Utilities": [],
    }
    
    for name, tool in state_tools.items():
        for category in tool.categories:
            parts = [p.strip() for p in category.split(":")]
            main_cat = parts[0]
            sub_cat = parts[1] if len(parts) > 1 else None
            
            if main_cat not in valid_categories:
                issues.append(AuditIssue(
                    severity="error",
                    category="invalid_category",
                    tool_name=name,
                    message=f"Invalid main category: '{main_cat}'",
                    details={
                        "state_file": tool.state_file_path,
                        "category": category,
                        "valid_categories": list(valid_categories.keys()),
                    },
                ))
            elif sub_cat and sub_cat not in valid_categories[main_cat] and valid_categories[main_cat]:
                issues.append(AuditIssue(
                    severity="error",
                    category="invalid_subcategory",
                    tool_name=name,
                    message=f"Invalid subcategory: '{sub_cat}' for '{main_cat}'",
                    details={
                        "state_file": tool.state_file_path,
                        "category": category,
                        "valid_subcategories": valid_categories[main_cat],
                    },
                ))
    
    return issues


def print_issues(issues: list[AuditIssue], issues_only: bool = False, json_output: bool = False):
    """Print the audit issues."""
    if json_output:
        output = []
        for issue in issues:
            output.append({
                "severity": issue.severity,
                "category": issue.category,
                "tool_name": issue.tool_name,
                "message": issue.message,
                "details": issue.details,
            })
        print(json.dumps(output, indent=2))
        return
    
    # Group by severity
    errors = [i for i in issues if i.severity == "error"]
    warnings = [i for i in issues if i.severity == "warning"]
    infos = [i for i in issues if i.severity == "info"]
    
    if errors:
        print(f"\n{'='*60}")
        print(f"ERRORS ({len(errors)})")
        print(f"{'='*60}")
        for issue in errors:
            print(f"\n❌ [{issue.category}] {issue.tool_name}")
            print(f"   {issue.message}")
            if issue.details:
                for key, value in issue.details.items():
                    print(f"   {key}: {value}")
    
    if warnings:
        print(f"\n{'='*60}")
        print(f"WARNINGS ({len(warnings)})")
        print(f"{'='*60}")
        for issue in warnings:
            print(f"\n⚠️  [{issue.category}] {issue.tool_name}")
            print(f"   {issue.message}")
            if issue.details:
                for key, value in issue.details.items():
                    if isinstance(value, list):
                        print(f"   {key}:")
                        for v in value:
                            print(f"     - {v}")
                    else:
                        print(f"   {key}: {value}")
    
    if infos and not issues_only:
        print(f"\n{'='*60}")
        print(f"INFO ({len(infos)})")
        print(f"{'='*60}")
        for issue in infos:
            print(f"\nℹ️  [{issue.category}] {issue.tool_name}")
            print(f"   {issue.message}")
    
    # Summary
    print(f"\n{'='*60}")
    print("SUMMARY")
    print(f"{'='*60}")
    print(f"Errors:   {len(errors)}")
    print(f"Warnings: {len(warnings)}")
    print(f"Info:     {len(infos)}")


def main():
    parser = argparse.ArgumentParser(
        description="Audit REMnux documentation against salt state files.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    
    parser.add_argument(
        "--check",
        help="Check a specific state file instead of all files",
    )
    
    parser.add_argument(
        "--issues-only",
        action="store_true",
        help="Show only errors and warnings, skip informational messages",
    )
    
    parser.add_argument(
        "--json",
        action="store_true",
        help="Output results in JSON format",
    )
    
    parser.add_argument(
        "--repo", "-r",
        default=None,
        help=f"Override the docs repository (default: {DEFAULT_DOCS_REPO})",
    )
    
    parser.add_argument(
        "--branch", "-b",
        default=DEFAULT_DOCS_BRANCH,
        help=f"Branch to check (default: {DEFAULT_DOCS_BRANCH})",
    )
    
    parser.add_argument(
        "--state-files-path",
        default=".",
        help="Path to salt-states repository (default: current directory)",
    )
    
    args = parser.parse_args()
    
    # Determine repository
    repo = args.repo or os.environ.get("DOCS_REPO", DEFAULT_DOCS_REPO)
    
    # Initialize backend
    github_token = os.environ.get("GITHUB_ACCESS_TOKEN")
    
    if github_token:
        backend = GitHubAPI(github_token, repo, args.branch)
    else:
        backend = GitSSH(repo, args.branch)
        try:
            backend.clone()
        except Exception as e:
            print(f"Error cloning repository: {e}", file=sys.stderr)
            sys.exit(1)
    
    # Determine state files path
    state_files_path = args.state_files_path
    if not os.path.isdir(os.path.join(state_files_path, "remnux")):
        # Try to find it relative to script location
        script_dir = Path(__file__).parent.parent
        if os.path.isdir(os.path.join(script_dir, "remnux")):
            state_files_path = str(script_dir)
    
    # Run audit
    try:
        issues = audit_docs(state_files_path, backend, args.check)
    finally:
        if isinstance(backend, GitSSH):
            backend.cleanup()
    
    # Print results
    print_issues(issues, args.issues_only, args.json)
    
    # Exit with error code if there are errors
    errors = [i for i in issues if i.severity == "error"]
    if errors:
        sys.exit(1)


if __name__ == "__main__":
    main()

