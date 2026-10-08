#!/usr/bin/env python3
"""
Pre-commit hook to validate .sls file frontmatter.

Checks:
1. Required fields present: Name, Website, Description, Author, License
2. Category (if present) uses valid values
3. URLs are well-formed
4. No trailing whitespace in values
5. Architecture (if present) lists valid architectures, and each one it leaves
   out has a note (Amd64: or Arm64:)
6. In documented tools (non-empty Category): no unknown, malformed, or
   duplicated keys, so a typo such as "Architechture:" can't vanish silently

Files without frontmatter, such as internal dependencies, are not checked.

Usage:
    python lint-frontmatter.py [file1.sls file2.sls ...]

Exit codes:
    0: All files valid
    1: Validation errors found
"""

import argparse
import re
import sys
from pathlib import Path
from urllib.parse import urlparse

from frontmatter import KNOWN_FIELDS, REPEATABLE_FIELDS, parse_header, validate_architecture


# Valid categories structure (from audit-docs.py)
VALID_CATEGORIES = {
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

# Required fields for documentation
REQUIRED_FIELDS = ["name", "website", "description", "author", "license"]

# Fields whose presence marks a file as having frontmatter. Files without any
# of these (internal dependencies, config states) are not checked.
FRONTMATTER_MARKERS = REQUIRED_FIELDS + ["category", "notes"]


def parse_frontmatter(file_path: Path):
    """
    Parse frontmatter from a .sls file.

    Returns:
        (header, errors_list)
    """
    try:
        content = file_path.read_text()
    except Exception as e:
        return None, [f"Could not read file: {e}"]

    header = parse_header(content)
    errors = [
        f"Line {line_num}: Trailing whitespace in '{key}' field"
        for line_num, key in header.trailing_whitespace
    ]
    return header, errors


def validate_url(url: str) -> bool:
    """Check if a URL is well-formed."""
    try:
        result = urlparse(url)
        return all([result.scheme, result.netloc])
    except Exception:
        return False


def validate_category(category: str) -> tuple[bool, str]:
    """
    Validate a category string.

    Returns:
        (is_valid, error_message)
    """
    parts = [p.strip() for p in category.split(":")]
    main_cat = parts[0]
    sub_cat = parts[1] if len(parts) > 1 else None

    if main_cat not in VALID_CATEGORIES:
        return False, f"Invalid main category: '{main_cat}'"

    valid_subs = VALID_CATEGORIES[main_cat]

    if sub_cat and valid_subs:
        if sub_cat not in valid_subs:
            return False, f"Invalid subcategory '{sub_cat}' for '{main_cat}'. Valid: {', '.join(valid_subs)}"
    elif sub_cat and not valid_subs:
        return False, f"Category '{main_cat}' does not have subcategories"
    elif not sub_cat and valid_subs:
        return False, f"Category '{main_cat}' requires a subcategory. Valid: {', '.join(valid_subs)}"

    return True, ""


def lint_file(file_path: Path) -> list[str]:
    """
    Lint a single .sls file.

    Returns list of error messages (empty if valid).
    """
    errors = []

    # Parse frontmatter
    header, parse_errors = parse_frontmatter(file_path)
    errors.extend(parse_errors)
    if header is None:
        return errors
    front_matter = header.fields

    # Only validate if at least one recognized frontmatter field is present
    # This allows files with no frontmatter (internal dependencies, config states)
    # and ignores false positives like "# https://..." being parsed as key: value
    has_known_fields = any(field in front_matter for field in FRONTMATTER_MARKERS)
    if not has_known_fields:
        return errors

    # Check required fields
    missing = [f for f in REQUIRED_FIELDS if f not in front_matter]
    if missing:
        errors.append(f"Missing required fields: {', '.join(missing)}")

    # Documented tools: reject keys the tooling would ignore or misread.
    # Undocumented states may keep free-form comment blocks (e.g. "# Behavior:").
    if front_matter.get("category"):
        for key, line_nums in header.key_lines.items():
            if key not in KNOWN_FIELDS:
                errors.append(f"Line {line_nums[0]}: Unknown frontmatter key '{key}'. Known keys: {', '.join(KNOWN_FIELDS)}")
            elif len(line_nums) > 1 and key not in REPEATABLE_FIELDS:
                errors.append(f"Lines {', '.join(map(str, line_nums))}: Key '{key}' appears more than once")
        for line_num, line in header.malformed:
            errors.append(f"Line {line_num}: Frontmatter keys must be one word: '{line.strip()}'")

    # Architecture and the per-architecture notes
    if "architecture" in front_matter or "amd64" in front_matter or "arm64" in front_matter:
        for err in validate_architecture(front_matter, require_notes=bool(front_matter.get("category"))):
            errors.append(f"Architecture error: {err}")

    # Validate website URL
    if "website" in front_matter:
        website = front_matter["website"]
        if website and not validate_url(website):
            errors.append(f"Invalid URL in Website field: '{website}'")

    # Validate category if present
    if "category" in front_matter:
        category_str = front_matter["category"]
        if category_str:  # Empty category is allowed (internal dependencies)
            categories = [c.strip() for c in category_str.split(",")]
            for cat in categories:
                if cat:  # Skip empty entries
                    is_valid, err_msg = validate_category(cat)
                    if not is_valid:
                        errors.append(f"Category error: {err_msg}")

    # Check author URL if present
    if "author" in front_matter:
        author = front_matter["author"]
        # Extract URLs from author field
        url_pattern = r'https?://[^\s,]+'
        urls = re.findall(url_pattern, author)
        for url in urls:
            if not validate_url(url):
                errors.append(f"Invalid URL in Author field: '{url}'")

    # Check license URL if present
    if "license" in front_matter:
        license_val = front_matter["license"]
        url_pattern = r'https?://[^\s,]+'
        urls = re.findall(url_pattern, license_val)
        for url in urls:
            if not validate_url(url):
                errors.append(f"Invalid URL in License field: '{url}'")

    return errors


def main():
    parser = argparse.ArgumentParser(
        description="Validate .sls file frontmatter for REMnux salt-states",
    )
    parser.add_argument(
        "files",
        nargs="*",
        help="Files to lint (passed by pre-commit)",
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Show all files being checked",
    )

    args = parser.parse_args()

    if not args.files:
        print("No files to check")
        sys.exit(0)

    had_errors = False

    for file_path_str in args.files:
        file_path = Path(file_path_str)

        if args.verbose:
            print(f"Checking: {file_path}")

        errors = lint_file(file_path)

        if errors:
            had_errors = True
            print(f"\n{file_path}:")
            for error in errors:
                print(f"  - {error}")

    if had_errors:
        print("\nFrontmatter validation failed. Please fix the errors above.")
        sys.exit(1)

    if args.verbose:
        print(f"\nAll {len(args.files)} file(s) passed validation.")

    sys.exit(0)


if __name__ == "__main__":
    main()
