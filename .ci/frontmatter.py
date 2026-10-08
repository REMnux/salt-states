"""
Shared parser for the comment frontmatter at the top of REMnux .sls files.

lint-frontmatter.py, update-docs.py, audit-docs.py, and audit-arch.py import this
module so that all four read the same keys the same way.

Frontmatter is the leading block of "# Key: Value" comment lines. Keys are single
words. Architecture metadata:

    # Architecture: amd64          Architectures REMnux installs the tool on. Omit
                                   the field when the tool works on both amd64 and
                                   arm64.
    # Arm64: <sentence>            For arm64 users. Required when Architecture
                                   leaves out arm64 (name an alternative, or write
                                   "No alternative identified."). Otherwise it
                                   describes what doesn't work on arm64.
    # Amd64: <sentence>            The same for amd64 users.
"""

import re
from dataclasses import dataclass, field

KEY_LINE = re.compile(r"^#\s*(\w+):\s*(.*)$")
# A key-shaped line that KEY_LINE can't read, such as "# Arm64 notes: ..." or
# "# Arm-64: ...". Indented continuation lines ("#   more text: ...") don't match.
MALFORMED_KEY_LINE = re.compile(r"^#\s?[A-Za-z][\w-]*(?: [\w-]+){0,2}:\s")

REQUIRED_FIELDS = ["name", "website", "description", "author", "license"]
OPTIONAL_FIELDS = ["category", "notes", "command", "architecture", "amd64", "arm64"]
REPEATABLE_FIELDS = ["tools"]
KNOWN_FIELDS = REQUIRED_FIELDS + OPTIONAL_FIELDS + REPEATABLE_FIELDS

ARCHES = ("amd64", "arm64")
ARCH_NAMES = {"amd64": "Intel/AMD (amd64)", "arm64": "ARM (arm64)"}


@dataclass
class Header:
    """Frontmatter of one .sls file."""
    fields: dict = field(default_factory=dict)       # lowercase key -> value (last one wins)
    tools_lines: list = field(default_factory=list)  # values of repeatable "# Tools:" lines
    key_lines: dict = field(default_factory=dict)    # lowercase key -> line numbers
    malformed: list = field(default_factory=list)    # (line number, line)
    trailing_whitespace: list = field(default_factory=list)  # (line number, key as written)


def parse_header(content: str) -> Header:
    """Parse the leading comment block of a .sls file."""
    header = Header()
    for line_num, line in enumerate(content.split("\n"), start=1):
        if not line.startswith("#"):
            break
        match = KEY_LINE.match(line)
        if not match:
            if MALFORMED_KEY_LINE.match(line):
                header.malformed.append((line_num, line))
            continue
        key = match.group(1).lower()
        value = match.group(2)
        if value != value.rstrip():
            header.trailing_whitespace.append((line_num, match.group(1)))
        value = value.strip()
        header.key_lines.setdefault(key, []).append(line_num)
        if key in REPEATABLE_FIELDS:
            header.tools_lines.append(value)
        else:
            header.fields[key] = value
    return header


def parse_architectures(fields: dict) -> tuple[tuple, list[str]]:
    """Return (architectures in ARCHES order, errors). A missing field means both."""
    if "architecture" not in fields:
        return ARCHES, []
    value = fields["architecture"]
    tokens = [t.strip().lower() for t in value.split(",") if t.strip()]
    if not tokens:
        return ARCHES, ["Architecture is empty. Omit the field for tools that work on both amd64 and arm64"]
    unknown = [t for t in tokens if t not in ARCHES]
    if unknown:
        return ARCHES, [f"Unknown architecture '{t}' in Architecture field. Valid: {', '.join(ARCHES)}" for t in unknown]
    return tuple(a for a in ARCHES if a in tokens), []


def arch_notes(fields: dict) -> dict:
    """Return {architecture: note} for the Amd64 and Arm64 fields that have text."""
    return {a: fields[a] for a in ARCHES if fields.get(a)}


def validate_architecture(fields: dict, require_notes: bool = True) -> list[str]:
    """Check the Architecture field and the notes it requires.

    Pass require_notes=False for states without a Category: they don't appear in
    the docs, so they don't need a note for a left-out architecture.
    """
    archs, errors = parse_architectures(fields)
    if errors:
        return errors
    notes = arch_notes(fields)
    for arch in ARCHES:
        if require_notes and arch not in archs and arch not in notes:
            errors.append(
                f"Architecture leaves out {arch}, so add an '{arch.capitalize()}:' line naming an "
                f"alternative for {arch} users (or 'No alternative identified.')"
            )
        if arch in fields and not fields[arch]:
            errors.append(f"'{arch.capitalize()}:' is empty")
    return errors


def availability_text(archs) -> str:
    """Human-readable availability, e.g. 'Intel/AMD (amd64) only'."""
    if len(archs) == len(ARCHES):
        return f"{ARCH_NAMES['amd64']} and {ARCH_NAMES['arm64']}"
    return f"{ARCH_NAMES[archs[0]]} only"


def arch_markdown_lines(archs, notes: dict) -> list[str]:
    """Docs lines for a tool entry, each ending in a markdown line break."""
    lines = [f"**Available on**: {availability_text(archs)}\\"]
    for arch in ARCHES:
        if arch in notes:
            label = "Limitations on" if arch in archs else "Alternative on"
            lines.append(f"**{label} {arch}**: {notes[arch]}\\")
    return lines


def split_tools_line(line: str):
    """Split a '# Tools:' value (name|description|website|categories), or return None."""
    parts = [p.strip() for p in line.split("|")]
    if len(parts) < 4:
        return None
    return {
        "name": parts[0],
        "description": parts[1],
        "website": parts[2],
        "categories": [c.strip() for c in parts[3].split(",") if c.strip()],
    }
