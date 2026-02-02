#!/usr/bin/env python3
"""
Update REMnux GitBook documentation based on SaltStack state files.

This script parses the front matter of .sls files and updates the corresponding
tool entries in the REMnux documentation repository (https://github.com/REMnux/docs).

The documentation is synced from GitHub to GitBook automatically.

Usage:
    # Update/create entries for a tool (requires GITHUB_TOKEN or SSH access)
    python update-docs.py remnux/tools/capa.sls

    # Dry-run mode (preview changes without applying)
    python update-docs.py --dry-run remnux/tools/capa.sls

    # Show detailed unified diff of changes
    python update-docs.py --dry-run --show-diff remnux/tools/capa.sls

    # Delete entries for a tool by name (no state file needed)
    python update-docs.py --delete "capa"

    # Delete entries for a tool using its state file
    python update-docs.py --delete remnux/tools/capa.sls

    # Test against a fork before modifying the main repo
    python update-docs.py --repo "myuser/docs" remnux/tools/capa.sls

    # Generate tools-index.json for MCP server (output to stdout)
    python update-docs.py --json-index > tools-index.json

    # Push tools-index.json to the MCP server repo
    python update-docs.py --sync-mcp

    # Preview MCP sync without pushing
    python update-docs.py --sync-mcp --dry-run --show-diff

Environment Variables:
    GITHUB_ACCESS_TOKEN: GitHub personal access token with repo write access.
                         If not set, the script will use SSH git access instead.
                         (Note: GITHUB_TOKEN is more common, but we use GITHUB_ACCESS_TOKEN
                         to avoid conflicts with GitHub Actions' automatic token.)
    DOCS_REPO: Override default docs repository (optional, default: REMnux/docs)

Options:
    --repo, -r      Override the documentation repository (e.g., "myuser/docs").
                    Useful for testing changes against a fork before applying
                    to the main REMnux/docs repository.

    --dry-run, -n   Preview what changes would be made without actually applying
                    them. Shows a summary of files that would be modified.

    --show-diff     Display a detailed unified diff of all changes (like git diff).
                    Can be combined with --dry-run to review changes before applying.

    --delete, -d    Delete mode. Accepts either:
                    - A tool name: --delete "capa" (deletes entries for "capa")
                    - A state file: --delete remnux/tools/capa.sls (extracts name from file)

    --branch, -b    Branch to update (default: master)

    --verbose, -v   Enable verbose output with additional details.

    --json-index    Output tools-index.json to stdout for MCP server use.
                    Scans all .sls files and extracts tool metadata.

    --sync-mcp      Push tools-index.json to the MCP server repo via GitHub API.
                    Supports --dry-run and --show-diff. Requires GITHUB_ACCESS_TOKEN.

    --salt-states-path  Path to salt-states directory (default: script's parent dir).

Frontmatter Fields:
    Required: Name, Website, Description, Author, License
    Optional: Category (comma-separated for multiple), Notes
    Optional: Command (comma-separated CLI command names for toolkits)
              If Command is not specified, derived from Name field.

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
from dataclasses import dataclass
from pathlib import Path
from typing import Optional
from urllib.request import Request, urlopen
from urllib.error import HTTPError


# Default configuration
DEFAULT_DOCS_REPO = "REMnux/docs"
DEFAULT_DOCS_BRANCH = "master"
DEFAULT_MCP_REPO = "REMnux/remnux-mcp-server"
DEFAULT_MCP_BRANCH = "main"
MCP_INDEX_PATH = "data/tools-index.json"
SALT_STATES_REPO = "REMnux/salt-states"
GITHUB_API_BASE = "https://api.gitbook.com"


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
    commands: list[str] = None  # CLI command names (from Command: field or derived)

    def __post_init__(self):
        if self.commands is None:
            self.commands = []

    def to_markdown(self) -> str:
        """Generate markdown entry for this tool."""
        lines = [
            f"## {self.name}",
            "",
            self.description,
            "",
            f"**Website**: [{self.website}]({self.website})\\",
            f"**Author**: {self._format_author()}\\",
            f"**License**: {self._format_license()}\\",
        ]
        
        if self.notes:
            lines.append(f"**Notes**: {self.notes}\\")
        
        # Add state file reference
        state_ref = self._get_state_file_reference()
        lines.append(f"**State File**: [{state_ref}](https://github.com/{SALT_STATES_REPO}/blob/master/{self.state_file_path})")
        
        return "\n".join(lines)
    
    def _format_author(self) -> str:
        """Format author field, converting URLs to markdown links."""
        author = self.author
        # Convert bare URLs to markdown links
        url_pattern = r'(https?://[^\s,]+)'
        
        def replace_url(match):
            url = match.group(1)
            return f"[{url}]({url})"
        
        return re.sub(url_pattern, replace_url, author)
    
    def _format_license(self) -> str:
        """Format license field, converting URLs to markdown links."""
        license_text = self.license
        # Convert bare URLs to markdown links
        url_pattern = r'(https?://[^\s,]+)'
        
        def replace_url(match):
            url = match.group(1)
            return f"[{url}]({url})"
        
        return re.sub(url_pattern, replace_url, license_text)
    
    def _get_state_file_reference(self) -> str:
        """Generate the state file reference (e.g., remnux.tools.capa)."""
        # Convert path like "remnux/tools/capa.sls" to "remnux.tools.capa"
        path = self.state_file_path.replace("/", ".").replace(".sls", "")
        return path


@dataclass 
class FileChange:
    """Represents a change to be made to a file."""
    file_path: str
    action: str  # "update", "create", "delete_entry"
    old_content: Optional[str] = None
    new_content: Optional[str] = None
    sha: Optional[str] = None  # Required for GitHub API updates
    tool_name: str = ""


class GitHubAPI:
    """GitHub API client for when GITHUB_TOKEN is available."""
    
    def __init__(self, token: str, repo: str, branch: str = "master"):
        self.token = token
        self.repo = repo
        self.branch = branch
        self.base_url = f"https://api.github.com/repos/{repo}"
    
    def _request(self, method: str, endpoint: str, data: Optional[dict] = None) -> dict:
        """Make an authenticated request to GitHub API."""
        url = f"{self.base_url}{endpoint}"
        headers = {
            "Authorization": f"Bearer {self.token}",
            "Accept": "application/vnd.github.v3+json",
            "User-Agent": "REMnux-Docs-Updater",
        }
        
        body = None
        if data:
            headers["Content-Type"] = "application/json"
            body = json.dumps(data).encode("utf-8")
        
        request = Request(url, data=body, headers=headers, method=method)
        
        try:
            with urlopen(request) as response:
                return json.loads(response.read().decode("utf-8"))
        except HTTPError as e:
            error_body = e.read().decode("utf-8") if e.fp else ""
            raise RuntimeError(f"GitHub API error {e.code}: {error_body}") from e
    
    def get_file_content(self, path: str) -> tuple[Optional[str], Optional[str]]:
        """Get file content as string and its SHA."""
        try:
            file_data = self._request("GET", f"/contents/{path}?ref={self.branch}")
            content = base64.b64decode(file_data["content"]).decode("utf-8")
            return content, file_data["sha"]
        except RuntimeError as e:
            if "404" in str(e):
                return None, None
            raise
    
    def list_directory(self, path: str) -> list[str]:
        """List files in a directory."""
        try:
            result = self._request("GET", f"/contents/{path}?ref={self.branch}")
            if isinstance(result, list):
                return [item["name"] for item in result]
            return []
        except RuntimeError:
            return []
    
    def update_file(self, path: str, content: str, message: str, sha: str) -> dict:
        """Update an existing file."""
        data = {
            "message": message,
            "content": base64.b64encode(content.encode("utf-8")).decode("utf-8"),
            "sha": sha,
            "branch": self.branch,
        }
        return self._request("PUT", f"/contents/{path}", data)
    
    def create_file(self, path: str, content: str, message: str) -> dict:
        """Create a new file."""
        data = {
            "message": message,
            "content": base64.b64encode(content.encode("utf-8")).decode("utf-8"),
            "branch": self.branch,
        }
        return self._request("PUT", f"/contents/{path}", data)


class GitSSH:
    """Git client for when using SSH access (no GITHUB_TOKEN)."""
    
    def __init__(self, repo: str, branch: str = "master"):
        self.repo = repo
        self.branch = branch
        self.temp_dir = None
        self.repo_path = None
    
    def _run_git(self, *args, cwd=None) -> str:
        """Run a git command and return output."""
        cmd = ["git"] + list(args)
        result = subprocess.run(
            cmd,
            cwd=cwd or self.repo_path,
            capture_output=True,
            text=True,
        )
        if result.returncode != 0:
            raise RuntimeError(f"Git command failed: {' '.join(cmd)}\n{result.stderr}")
        return result.stdout
    
    def clone(self):
        """Clone the repository."""
        self.temp_dir = tempfile.mkdtemp(prefix="remnux-docs-")
        ssh_url = f"git@github.com:{self.repo}.git"
        
        print(f"Cloning {self.repo} via SSH...")
        self._run_git("clone", "--branch", self.branch, "--depth", "1", ssh_url, self.temp_dir, cwd="/tmp")
        self.repo_path = self.temp_dir
        print(f"  ✓ Cloned to {self.temp_dir}")
    
    def get_file_content(self, path: str) -> tuple[Optional[str], Optional[str]]:
        """Get file content. Returns (content, None) - SHA not needed for git."""
        file_path = Path(self.repo_path) / path
        if not file_path.exists():
            return None, None
        return file_path.read_text(), None
    
    def list_directory(self, path: str) -> list[str]:
        """List files in a directory."""
        dir_path = Path(self.repo_path) / path
        if not dir_path.exists():
            return []
        return [f.name for f in dir_path.iterdir()]
    
    def write_file(self, path: str, content: str):
        """Write content to a file."""
        file_path = Path(self.repo_path) / path
        file_path.parent.mkdir(parents=True, exist_ok=True)
        file_path.write_text(content)
    
    def commit_and_push(self, message: str):
        """Stage all changes, commit, and push."""
        self._run_git("add", "-A")
        
        # Check if there are changes to commit
        status = self._run_git("status", "--porcelain")
        if not status.strip():
            print("No changes to commit.")
            return
        
        self._run_git("commit", "-m", message)
        print(f"Pushing to {self.branch}...")
        self._run_git("push", "origin", self.branch)
        print("  ✓ Pushed successfully")
    
    def cleanup(self):
        """Remove the temporary directory."""
        if self.temp_dir and Path(self.temp_dir).exists():
            shutil.rmtree(self.temp_dir)


def parse_front_matter(file_path: str) -> ToolInfo:
    """Parse the front matter from a salt state file."""
    with open(file_path, "r") as f:
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
    
    # Validate required fields (category can be empty for internal dependencies)
    required_fields = ["name", "website", "description", "author", "license"]
    missing = [f for f in required_fields if f not in front_matter]
    if missing:
        raise ValueError(f"Missing required front matter fields: {', '.join(missing)}")
    
    # Parse categories (can be comma-separated for multiple categories)
    # Filter out empty categories - tools with no category are internal dependencies
    # and should not appear in the documentation
    category_str = front_matter.get("category", "")
    categories = [c.strip() for c in category_str.split(",") if c.strip()]

    # Parse commands (can be comma-separated for toolkits)
    # Priority: 1) Command: field, 2) Name field (normalized), 3) state file name
    command_str = front_matter.get("command", "")
    if command_str:
        commands = [c.strip() for c in command_str.split(",") if c.strip()]
    else:
        # Derive from Name field (more accurate than filename)
        # Normalize: lowercase, keep alphanumeric and hyphens
        name = front_matter["name"]
        normalized = re.sub(r'[^a-zA-Z0-9\-]', '', name.lower().replace(' ', '-'))
        # Remove leading/trailing hyphens and collapse multiple hyphens
        normalized = re.sub(r'-+', '-', normalized).strip('-')
        commands = [normalized] if normalized else [Path(file_path).stem]

    # Get relative path from salt-states root
    file_path_obj = Path(file_path)
    # Try to find the relative path from remnux/
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
        commands=commands,
    )


def category_to_file_path(category: str, backend) -> Optional[str]:
    """
    Convert a category string to a documentation file path.
    
    Examples:
        "Statically Analyze Code: PE Files" -> "discover-the-tools/statically+analyze+code/pe-files.md"
        "Analyze Documents: Microsoft Office" -> "discover-the-tools/analyze+documents/microsoft+office.md"
        "Perform Memory Forensics" -> "discover-the-tools/perform+memory+forensics.md"
    
    Returns None if the category file doesn't exist in the docs.
    """
    parts = [p.strip() for p in category.split(":")]
    
    if len(parts) == 1:
        # Single-level category (e.g., "Perform Memory Forensics")
        main_cat = parts[0].lower().replace(" ", "+")
        candidates = [f"discover-the-tools/{main_cat}.md"]
    else:
        # Two-level category (e.g., "Statically Analyze Code: PE Files")
        main_cat = parts[0].lower().replace(" ", "+")
        subcat = parts[1].lower().replace(" ", "+")
        
        # Try different naming conventions (files might use + or -)
        candidates = [
            f"discover-the-tools/{main_cat}/{subcat}.md",
            f"discover-the-tools/{main_cat}/{subcat.replace('+', '-')}.md",
        ]
    
    # Check which one exists
    for path in candidates:
        content, _ = backend.get_file_content(path)
        if content is not None:
            return path
    
    return None


def find_tool_in_content(content: str, tool_name: str, case_sensitive: bool = True) -> tuple[int, int, str]:
    """
    Find the start and end line numbers of a tool entry in markdown content.
    
    Args:
        content: The markdown content to search
        tool_name: The tool name to find
        case_sensitive: If False, match tool name case-insensitively
    
    Returns (start_line, end_line, actual_name) or (-1, -1, "") if not found.
    The actual_name is the tool name as it appears in the document (preserving case).
    """
    lines = content.split("\n")
    start_line = -1
    end_line = -1
    actual_name = ""
    
    for i, line in enumerate(lines):
        # Check if this is a tool heading (## ToolName or ## ToolName <a href...>)
        if line.startswith("## "):
            # Extract tool name, handling potential anchor links
            found_name = line[3:].strip()
            # Remove anchor links like <a href="#numbers-to-string" id="numbers-to-string"></a>
            found_name = re.sub(r'\s*<a\s+[^>]*>.*?</a>\s*$', '', found_name).strip()
            
            # Compare names (case-sensitive or insensitive)
            if case_sensitive:
                matches = (found_name == tool_name)
            else:
                matches = (found_name.lower() == tool_name.lower())
            
            if matches and start_line == -1:
                start_line = i
                actual_name = found_name
                continue
        
        if start_line >= 0:
            # Look for the next heading or end of file
            if line.startswith("## ") or i == len(lines) - 1:
                end_line = i if line.startswith("## ") else i + 1
                break
    
    if start_line == -1:
        return -1, -1, ""
    
    if end_line == -1:
        end_line = len(lines)
    
    return start_line, end_line, actual_name


def update_tool_in_content(content: str, tool: ToolInfo, delete: bool = False) -> tuple[str, str]:
    """
    Update or add a tool entry in markdown content.
    
    Returns (new_content, action) where action is "updated", "added", "deleted", or "not_found".
    """
    start_line, end_line, _ = find_tool_in_content(content, tool.name, case_sensitive=True)
    lines = content.split("\n")
    
    if delete:
        if start_line == -1:
            return content, "not_found"
        
        # Remove the tool entry (and any trailing blank lines)
        while end_line < len(lines) and lines[end_line].strip() == "":
            end_line += 1
        
        new_lines = lines[:start_line] + lines[end_line:]
        return "\n".join(new_lines), "deleted"
    
    tool_markdown = tool.to_markdown()
    
    if start_line >= 0:
        # Update existing entry
        # Remove trailing blank lines from the entry
        while end_line > start_line and lines[end_line - 1].strip() == "":
            end_line -= 1
        
        new_lines = lines[:start_line] + tool_markdown.split("\n") + [""] + lines[end_line:]
        return "\n".join(new_lines), "updated"
    else:
        # Add new entry at the end
        # Find a good insertion point - after the last tool entry
        insert_line = len(lines)
        
        # Look for the last ## heading
        for i in range(len(lines) - 1, -1, -1):
            if lines[i].startswith("## "):
                # Find end of this tool's entry
                for j in range(i + 1, len(lines)):
                    if lines[j].startswith("## "):
                        insert_line = j
                        break
                else:
                    insert_line = len(lines)
                break
        
        # Ensure proper spacing
        if insert_line == len(lines) and len(lines) > 0:
            if lines[-1].strip() != "":
                lines.append("")
            new_lines = lines + tool_markdown.split("\n") + [""]
        else:
            new_lines = lines[:insert_line] + [""] + tool_markdown.split("\n") + [""] + lines[insert_line:]
        
        return "\n".join(new_lines), "added"


def delete_tool_from_content(content: str, tool_name: str) -> tuple[str, str, str]:
    """
    Delete a tool entry by name from markdown content (case-insensitive search).
    
    Returns (new_content, action, actual_name) where:
        - action is "deleted" or "not_found"
        - actual_name is the tool name as it appeared in the doc (preserving original case)
    """
    start_line, end_line, actual_name = find_tool_in_content(content, tool_name, case_sensitive=False)
    lines = content.split("\n")
    
    if start_line == -1:
        return content, "not_found", ""
    
    # Remove the tool entry (and any trailing blank lines)
    while end_line < len(lines) and lines[end_line].strip() == "":
        end_line += 1
    
    new_lines = lines[:start_line] + lines[end_line:]
    return "\n".join(new_lines), "deleted", actual_name


def find_tool_in_docs(tool_name: str, backend) -> list[tuple[str, str, Optional[str], str]]:
    """
    Search all documentation files for a tool by name (case-insensitive).
    
    Returns list of (file_path, content, sha, actual_name) tuples where the tool was found.
    The actual_name is the tool name as it appears in the document (preserving case).
    """
    found = []
    
    # Get list of category directories and files
    discover_tools_contents = backend.list_directory("discover-the-tools")
    
    for item in discover_tools_contents:
        if item.endswith(".md"):
            # Top-level category file
            path = f"discover-the-tools/{item}"
            content, sha = backend.get_file_content(path)
            if content:
                start, _, actual_name = find_tool_in_content(content, tool_name, case_sensitive=False)
                if start >= 0:
                    found.append((path, content, sha, actual_name))
        else:
            # Subdirectory - check files inside
            subdir_contents = backend.list_directory(f"discover-the-tools/{item}")
            for subitem in subdir_contents:
                if subitem.endswith(".md"):
                    path = f"discover-the-tools/{item}/{subitem}"
                    content, sha = backend.get_file_content(path)
                    if content:
                        start, _, actual_name = find_tool_in_content(content, tool_name, case_sensitive=False)
                        if start >= 0:
                            found.append((path, content, sha, actual_name))
    
    return found


def prepare_changes(
    tool: Optional[ToolInfo],
    tool_name: Optional[str],
    backend,
    delete: bool = False,
) -> list[FileChange]:
    """Prepare the list of file changes needed."""
    changes = []
    
    if delete:
        # Delete mode - search all docs for the tool name (case-insensitive)
        name_to_delete = tool_name if tool_name else tool.name
        found_locations = find_tool_in_docs(name_to_delete, backend)
        
        if not found_locations:
            print(f"Warning: Tool '{name_to_delete}' not found in any documentation files (case-insensitive search)", file=sys.stderr)
            return []
        
        for file_path, content, sha, actual_name in found_locations:
            new_content, action, _ = delete_tool_from_content(content, name_to_delete)
            if action == "deleted":
                changes.append(FileChange(
                    file_path=file_path,
                    action="delete_entry",
                    old_content=content,
                    new_content=new_content,
                    sha=sha,
                    tool_name=actual_name,  # Use the actual name from the doc
                ))
        
        return changes
    
    # Update/add mode - need a full ToolInfo
    if tool is None:
        raise ValueError("ToolInfo required for update/add operations")
    
    for category in tool.categories:
        file_path = category_to_file_path(category, backend)
        
        if file_path is None:
            print(f"Warning: Category '{category}' does not exist in the documentation. Skipping.", file=sys.stderr)
            print(f"  (You may need to create the category page manually first)", file=sys.stderr)
            continue
        
        content, sha = backend.get_file_content(file_path)
        
        if content is None:
            print(f"Warning: Could not read file '{file_path}'. Skipping.", file=sys.stderr)
            continue
        
        new_content, action = update_tool_in_content(content, tool, delete=False)
        
        if new_content != content:
            changes.append(FileChange(
                file_path=file_path,
                action="update" if action == "updated" else "add",
                old_content=content,
                new_content=new_content,
                sha=sha,
                tool_name=tool.name,
            ))
    
    return changes


def apply_changes_api(changes: list[FileChange], github: GitHubAPI) -> bool:
    """Apply changes using the GitHub API."""
    for change in changes:
        try:
            if change.action == "add":
                commit_msg = f"docs: Add documentation for {change.tool_name}"
            elif change.action == "update":
                commit_msg = f"docs: Update documentation for {change.tool_name}"
            else:
                commit_msg = f"docs: Remove documentation for {change.tool_name}"
            
            github.update_file(change.file_path, change.new_content, commit_msg, change.sha)
            print(f"  ✓ Updated {change.file_path}")
        
        except Exception as e:
            print(f"  ✗ Error: {e}", file=sys.stderr)
            return False
    
    return True


def apply_changes_git(changes: list[FileChange], git: GitSSH) -> bool:
    """Apply changes using git SSH."""
    for change in changes:
        git.write_file(change.file_path, change.new_content)
        print(f"  ✓ Modified {change.file_path}")
    
    # Determine commit message
    tool_names = list(set(c.tool_name for c in changes))
    if len(tool_names) == 1:
        actions = set(c.action for c in changes)
        if actions == {"delete_entry"}:
            commit_msg = f"docs: Remove documentation for {tool_names[0]}"
        elif "add" in actions:
            commit_msg = f"docs: Add documentation for {tool_names[0]}"
        else:
            commit_msg = f"docs: Update documentation for {tool_names[0]}"
    else:
        commit_msg = f"docs: Update documentation for {len(tool_names)} tools"
    
    git.commit_and_push(commit_msg)
    return True


def scan_all_tools(salt_states_path: str, verbose: bool = False) -> list[ToolInfo]:
    """Scan all .sls files and return list of tools with valid frontmatter."""
    tools = []
    skipped_no_category = []
    skipped_parse_error = []
    remnux_path = Path(salt_states_path) / "remnux"

    if not remnux_path.exists():
        print(f"Error: remnux directory not found at {remnux_path}", file=sys.stderr)
        return tools

    for sls_file in remnux_path.rglob("*.sls"):
        # Skip init.sls files (usually just includes)
        if sls_file.name == "init.sls":
            continue

        try:
            tool = parse_front_matter(str(sls_file))
            # Only include tools with categories (skip internal dependencies)
            if tool.categories:
                tools.append(tool)
            else:
                skipped_no_category.append(sls_file.name)
        except ValueError as e:
            # Missing required frontmatter - skip
            skipped_parse_error.append((sls_file.name, str(e)))
            continue

    if verbose:
        if skipped_no_category:
            print(f"# Skipped {len(skipped_no_category)} tools without category (internal dependencies)", file=sys.stderr)
        if skipped_parse_error:
            print(f"# Skipped {len(skipped_parse_error)} files with missing frontmatter:", file=sys.stderr)
            for name, err in skipped_parse_error[:5]:
                print(f"#   {name}: {err}", file=sys.stderr)
            if len(skipped_parse_error) > 5:
                print(f"#   ... and {len(skipped_parse_error) - 5} more", file=sys.stderr)

    return tools


def generate_json_index(tools: list[ToolInfo]) -> dict:
    """Generate tools-index.json structure from list of tools."""
    from datetime import datetime

    entries = []
    for tool in tools:
        # Generate one entry per command (toolkits have multiple commands)
        for command in tool.commands:
            entry = {
                "command": command,
                "name": tool.name,
                "category": tool.categories[0] if tool.categories else "",
                "description": tool.description,
                "website": tool.website,
            }
            entries.append(entry)

    # Sort by command name
    entries.sort(key=lambda e: e["command"].lower())

    return {
        "version": "1.0.0",
        "updated": datetime.now().strftime("%Y-%m-%d"),
        "tools": entries,
    }


def show_diff(changes: list[FileChange]):
    """Show a unified diff of the changes."""
    import difflib
    
    for change in changes:
        print(f"\n{'=' * 60}")
        print(f"File: {change.file_path}")
        print(f"Action: {change.action}")
        print(f"Tool: {change.tool_name}")
        print(f"{'=' * 60}")
        
        if change.old_content and change.new_content:
            diff = difflib.unified_diff(
                change.old_content.split("\n"),
                change.new_content.split("\n"),
                fromfile=f"a/{change.file_path}",
                tofile=f"b/{change.file_path}",
                lineterm="",
            )
            for line in diff:
                print(line)
        elif change.new_content:
            print("(New file)")
            for line in change.new_content.split("\n")[:30]:
                print(f"+ {line}")
            if len(change.new_content.split("\n")) > 30:
                print(f"... ({len(change.new_content.split(chr(10))) - 30} more lines)")


def main():
    parser = argparse.ArgumentParser(
        description="Update REMnux GitBook documentation from salt state files.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Update documentation for a tool
  %(prog)s remnux/tools/capa.sls

  # Preview changes without applying
  %(prog)s --dry-run --show-diff remnux/tools/capa.sls

  # Delete a tool by name
  %(prog)s --delete "capa"

  # Delete a tool using its state file
  %(prog)s --delete remnux/tools/capa.sls

  # Test against a fork
  %(prog)s --repo "myuser/docs" remnux/tools/capa.sls

Environment:
  GITHUB_ACCESS_TOKEN   GitHub personal access token (if not set, uses SSH)
  DOCS_REPO       Override default docs repository
""",
    )
    
    parser.add_argument(
        "target",
        nargs="?",
        help="Path to .sls file, or tool name when using --delete",
    )
    
    parser.add_argument(
        "--dry-run", "-n",
        action="store_true",
        help="Preview changes without applying them",
    )
    
    parser.add_argument(
        "--delete", "-d",
        action="store_true",
        help="Delete the tool entries. Target can be a tool name or .sls file",
    )
    
    parser.add_argument(
        "--repo", "-r",
        default=None,
        help=f"Override the docs repository (default: {DEFAULT_DOCS_REPO}). "
             "Useful for testing changes against a fork.",
    )
    
    parser.add_argument(
        "--branch", "-b",
        default=DEFAULT_DOCS_BRANCH,
        help=f"Branch to update (default: {DEFAULT_DOCS_BRANCH})",
    )
    
    parser.add_argument(
        "--show-diff",
        action="store_true",
        help="Show detailed unified diff of changes (like git diff)",
    )
    
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose output",
    )

    parser.add_argument(
        "--json-index",
        action="store_true",
        help="Output tools-index.json to stdout (for MCP server bundled fallback)",
    )

    parser.add_argument(
        "--salt-states-path",
        default=None,
        help="Path to salt-states directory (default: parent of this script's directory)",
    )

    parser.add_argument(
        "--sync-mcp",
        action="store_true",
        help="Push tools-index.json to the MCP server repo via GitHub API",
    )

    args = parser.parse_args()

    # Handle --json-index mode
    if args.json_index:
        # Determine salt-states path
        if args.salt_states_path:
            salt_states_path = args.salt_states_path
        else:
            # Default: parent of .ci directory (where this script lives)
            salt_states_path = str(Path(__file__).parent.parent)

        tools = scan_all_tools(salt_states_path, verbose=args.verbose)
        if not tools:
            print("Error: No tools found", file=sys.stderr)
            sys.exit(1)

        index = generate_json_index(tools)
        print(json.dumps(index, indent=2))
        print(f"\n# Generated {len(index['tools'])} tool entries from {len(tools)} state files", file=sys.stderr)
        sys.exit(0)

    # Handle --sync-mcp mode
    if args.sync_mcp:
        import difflib

        # Determine salt-states path
        if args.salt_states_path:
            salt_states_path = args.salt_states_path
        else:
            salt_states_path = str(Path(__file__).parent.parent)

        # Generate the index
        tools = scan_all_tools(salt_states_path, verbose=args.verbose)
        if not tools:
            print("Error: No tools found", file=sys.stderr)
            sys.exit(1)

        index = generate_json_index(tools)
        new_content = json.dumps(index, indent=2) + "\n"

        mcp_repo = DEFAULT_MCP_REPO
        commit_msg = "chore: update tools-index.json from salt-states"

        # Fetch existing content from the MCP repo
        existing_content = None
        sha = None
        git = None  # SSH backend handle, if used

        github_token = os.environ.get("GITHUB_ACCESS_TOKEN")
        if github_token:
            mcp_api = GitHubAPI(github_token, mcp_repo, DEFAULT_MCP_BRANCH)
            existing_content, sha = mcp_api.get_file_content(MCP_INDEX_PATH)
        else:
            print("No GITHUB_ACCESS_TOKEN found, using SSH fallback...")
            git = GitSSH(mcp_repo, DEFAULT_MCP_BRANCH)
            git.clone()
            existing_content, _ = git.get_file_content(MCP_INDEX_PATH)

        try:
            # Compare tools arrays only — the "updated" timestamp changes every run
            changed = True
            if existing_content is not None:
                try:
                    existing_index = json.loads(existing_content)
                    if existing_index.get("tools") == index["tools"]:
                        changed = False
                except (json.JSONDecodeError, KeyError):
                    pass  # Existing file is malformed; overwrite it

            if not changed:
                print(f"No changes needed in {mcp_repo}/{MCP_INDEX_PATH}")
                sys.exit(0)

            # Show diff if requested
            if args.show_diff and existing_content is not None:
                old_lines = existing_content.splitlines(keepends=True)
                new_lines = new_content.splitlines(keepends=True)
                diff = difflib.unified_diff(
                    old_lines, new_lines,
                    fromfile=f"a/{MCP_INDEX_PATH}",
                    tofile=f"b/{MCP_INDEX_PATH}",
                )
                sys.stdout.writelines(diff)

            # Dry-run: print summary and exit
            if args.dry_run:
                tool_count = len(index["tools"])
                print(f"[dry-run] Would update {MCP_INDEX_PATH} in {mcp_repo} ({tool_count} tool entries)")
                sys.exit(0)

            # Push the update
            if github_token:
                if sha:
                    mcp_api.update_file(MCP_INDEX_PATH, new_content, commit_msg, sha)
                else:
                    mcp_api.create_file(MCP_INDEX_PATH, new_content, commit_msg)
            else:
                git.write_file(MCP_INDEX_PATH, new_content)
                git.commit_and_push(commit_msg)

            print(f"Updated {MCP_INDEX_PATH} in {mcp_repo} ({len(index['tools'])} tool entries)")
            sys.exit(0)
        finally:
            if git:
                git.cleanup()

    # Validate arguments
    if not args.target:
        parser.error("Target is required (state file path or tool name with --delete)")
    
    # Determine if target is a tool name or file path
    tool = None
    tool_name = None
    
    if args.delete and not args.target.endswith(".sls"):
        # Target is a tool name for deletion
        tool_name = args.target
    else:
        # Target is a state file
        if not os.path.isfile(args.target):
            print(f"Error: State file not found: {args.target}", file=sys.stderr)
            sys.exit(1)
        
        if not args.target.endswith(".sls"):
            print(f"Error: File must be a .sls salt state file: {args.target}", file=sys.stderr)
            sys.exit(1)
        
        try:
            tool = parse_front_matter(args.target)
        except ValueError as e:
            print(f"Error parsing state file: {e}", file=sys.stderr)
            sys.exit(1)
    
    # Get repository
    repo = args.repo or os.environ.get("DOCS_REPO", DEFAULT_DOCS_REPO)
    
    # Determine which backend to use
    github_token = os.environ.get("GITHUB_ACCESS_TOKEN")
    use_ssh = github_token is None
    
    # Check if tool has categories (tools without categories are internal dependencies
    # and should not appear in documentation)
    if tool and not tool.categories and not args.delete:
        print(f"Tool '{tool.name}' has no categories defined.")
        print("Tools without categories are internal dependencies and are not documented.")
        print("If this tool should be documented, add a Category to its state file.")
        sys.exit(0)
    
    if args.verbose:
        if tool:
            print(f"Tool: {tool.name}")
            print(f"Categories: {', '.join(tool.categories) if tool.categories else '(none)'}")
        else:
            print(f"Tool name: {tool_name}")
        print(f"Repository: {repo}")
        print(f"Branch: {args.branch}")
        print(f"Backend: {'SSH/Git' if use_ssh else 'GitHub API'}")
        print()
    
    # Initialize backend
    if use_ssh:
        if args.dry_run:
            print("Note: Using SSH backend. Cloning repository for dry-run preview...")
        backend = GitSSH(repo, args.branch)
        try:
            backend.clone()
        except Exception as e:
            print(f"Error cloning repository: {e}", file=sys.stderr)
            print("Make sure you have SSH access to the repository.", file=sys.stderr)
            sys.exit(1)
    else:
        backend = GitHubAPI(github_token, repo, args.branch)
    
    # Prepare changes
    try:
        changes = prepare_changes(tool, tool_name, backend, delete=args.delete)
    except Exception as e:
        print(f"Error preparing changes: {e}", file=sys.stderr)
        if use_ssh:
            backend.cleanup()
        sys.exit(1)
    
    if not changes:
        print("No changes needed.")
        if use_ssh:
            backend.cleanup()
        sys.exit(0)
    
    # Show summary
    print(f"\nChanges to apply ({len(changes)} file(s)):")
    for change in changes:
        action_verb = {
            "update": "Update",
            "add": "Add",
            "delete_entry": "Remove",
        }.get(change.action, change.action)
        print(f"  • {action_verb} '{change.tool_name}' in {change.file_path}")
    
    # Show diff if requested
    if args.show_diff:
        show_diff(changes)
    
    # Apply changes
    if args.dry_run:
        print("\n[DRY RUN] No changes were made.")
        if use_ssh:
            backend.cleanup()
        sys.exit(0)
    
    print()
    
    try:
        if use_ssh:
            success = apply_changes_git(changes, backend)
        else:
            success = apply_changes_api(changes, backend)
    finally:
        if use_ssh:
            backend.cleanup()
    
    if success:
        print(f"\n✓ All changes applied successfully.")
        print(f"View the changes at: https://github.com/{repo}")
        print("GitBook will automatically sync the changes within a few minutes.")
    else:
        print("\n✗ Some changes failed to apply.", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()

