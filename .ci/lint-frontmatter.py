#!/usr/bin/env python3
"""
Pre-commit hook to validate .sls file frontmatter.

Checks:
1. Required fields present: Name, Website, Description, Author, License
2. Category (if present) uses valid values
3. URLs are well-formed
4. No trailing whitespace in values

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


# Valid categories structure (from audit-docs.py)
VALID_CATEGORIES = {
    "Examine Static Properties": ["General", "PE Files", "ELF Files", ".NET", "Deobfuscation"],
    "Statically Analyze Code": ["General", "Unpacking", "PE Files", "Python", "Scripts", "Java", ".NET", "Flash", "Android"],
    "Dynamically Reverse-Engineer Code": ["General", "Shellcode", "Scripts", "ELF Files"],
    "Perform Memory Forensics": [],
    "Explore Network Interactions": ["Monitoring", "Connecting", "Services"],
    "Investigate System Interactions": [],
    "Analyze Documents": ["General", "PDF", "Microsoft Office", "Email Messages"],
    "Gather and Analyze Data": [],
    "View or Edit Files": [],
    "General Utilities": [],
}

# Required fields for documentation
REQUIRED_FIELDS = ["name", "website", "description", "author", "license"]


def parse_frontmatter(file_path: Path) -> tuple[dict, list[str]]:
    """
    Parse frontmatter from a .sls file.

    Returns:
        (fields_dict, errors_list)
    """
    errors = []
    front_matter = {}

    try:
        content = file_path.read_text()
    except Exception as e:
        return {}, [f"Could not read file: {e}"]

    lines = content.split("\n")

    for line_num, line in enumerate(lines, start=1):
        # Stop at first non-comment line
        if not line.startswith("#"):
            break

        # Parse "# Key: Value" format
        match = re.match(r"^#\s*(\w+):\s*(.*)$", line)
        if match:
            key = match.group(1).lower()
            value = match.group(2)

            # Check for trailing whitespace
            if value != value.rstrip():
                errors.append(f"Line {line_num}: Trailing whitespace in '{match.group(1)}' field")

            front_matter[key] = value.strip()

    return front_matter, errors


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
    front_matter, parse_errors = parse_frontmatter(file_path)
    errors.extend(parse_errors)

    if not front_matter:
        # No frontmatter found - this might be an init.sls or internal file
        # Only warn if it's not an init.sls
        if file_path.name != "init.sls":
            errors.append("No frontmatter found (expected # Name: ... at start of file)")
        return errors

    # Check required fields
    missing = [f for f in REQUIRED_FIELDS if f not in front_matter]
    if missing:
        errors.append(f"Missing required fields: {', '.join(missing)}")

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
