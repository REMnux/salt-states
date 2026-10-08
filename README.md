# REMnux Salt States

SaltStack state files for building and maintaining the [REMnux](https://remnux.org) Linux distribution for malware analysis. For a detailed explanation of how REMnux uses SaltStack, see [SaltStack Management](https://docs.remnux.org/behind-the-scenes/technologies/saltstack-management).

## Table of Contents

- [Repository Structure](#repository-structure)
- [State Files](#state-files)
- [init.sls Files](#initsls-files)
- [Adding or Updating a Tool](#adding-or-updating-a-tool)
- [Removing a Tool](#removing-a-tool)
- [Documentation Management](#documentation-management)
- [Issuing a Salt-States Release](#issuing-a-salt-states-release)
- [CI Scripts](#ci-scripts)

## Repository Structure

```
remnux/
├── addon.sls          # Bundle: Tools only (no theme/desktop changes)
├── cloud.sls          # Bundle: Full environment, keeps SSH enabled for remote access
├── dedicated.sls      # Bundle: Full environment for local systems (disables SSH)
├── packages/          # System packages (apt)
├── python3-packages/  # Python 3 packages (pip/virtualenv)
├── node-packages/     # Node.js packages (npm)
├── perl-packages/     # Perl modules (CPAN)
├── rubygems/          # Ruby gems
├── scripts/           # Standalone scripts
├── tools/             # Binary tools and applications
├── repos/             # Package repository configurations
├── config/            # Configuration files
└── theme/             # Desktop environment customization
```

For instructions on invoking these bundles directly with SaltStack (bypassing the REMnux installer), see [State Files Without the REMnux Installer](https://docs.remnux.org/behind-the-scenes/technologies/state-files-without-the-remnux-installer).

## State Files

Each `.sls` file defines how to install and configure a tool using SaltStack's YAML-based syntax. State files for user-facing tools include a frontmatter block at the top.

For examples of state files installing Ubuntu packages, pip packages, and configuring tools, see the [SaltStack Management documentation](https://docs.remnux.org/behind-the-scenes/technologies/saltstack-management).

### Frontmatter Format

```yaml
# Name: Tool Name
# Website: https://example.com/tool
# Description: Brief description of what the tool does.
# Category: Category Name
# Author: Author Name or URL
# License: License type: https://license-url
# Architecture: amd64
# Arm64: Use another-tool instead.
# Notes: Usage notes, commands, or additional info
```

| Field | Required | Description |
|-------|----------|-------------|
| `Name` | Yes | Display name for the tool |
| `Website` | Yes | Primary URL (project homepage or repository) |
| `Description` | Yes | One-line description (required for documentation) |
| `Category` | Required* | Documentation category (*omit for internal dependencies) |
| `Author` | Yes | Creator name or URL |
| `License` | Yes | License name and URL |
| `Architecture` | No | `amd64` or `arm64` when REMnux installs the tool on only one architecture. Omit it when the tool works on both |
| `Arm64`, `Amd64` | Sometimes | One sentence for users of that architecture. See [Architecture Fields](#architecture-fields) |
| `Notes` | No | Command names, usage tips, compatibility notes |
| `Command` | No | Comma-separated command names, when they differ from `Name` |
| `Tools` | No | Repeatable `name\|description\|website\|categories` line that documents each script of a collection as its own entry |

Frontmatter keys are single words. In documented tools (those with a `Category`), `.ci/lint-frontmatter.py` rejects unknown, misspelled, and repeated keys.

### Architecture Fields

REMnux installs on amd64 (Intel and AMD) and arm64 (ARM) systems. Most tools work on both, so omit these fields for them. Add the fields when a tool's state installs something different on one architecture:

| Situation | Frontmatter | Shown on docs.remnux.org |
|-----------|-------------|--------------------------|
| Works on both | (nothing) | **Available on**: Intel/AMD (amd64) and ARM (arm64) |
| Works on both, but some features are missing on arm64 | `# Arm64: JavaScript emulation is unavailable.` | **Available on**: Intel/AMD (amd64) and ARM (arm64)<br>**Limitations on arm64**: JavaScript emulation is unavailable. |
| amd64 only | `# Architecture: amd64`<br>`# Arm64: Use file or Detect It Easy instead.` | **Available on**: Intel/AMD (amd64) only<br>**Alternative on arm64**: Use file or Detect It Easy instead. |
| arm64 only | `# Architecture: arm64`<br>`# Amd64: No alternative identified.` | **Available on**: ARM (arm64) only<br>**Alternative on amd64**: No alternative identified. |

When `Architecture` leaves out an architecture, the matching note is required. Name an alternative, or write `No alternative identified.`

To skip an architecture, a state must display a notification during installation. Its text starts with `Skipped on <arch>:`, for example:

```yaml
remnux-tools-example-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: Example is not available for this architecture."
```

`.ci/audit-arch.py` checks the `Architecture` field against what each documented state installs on each architecture (see [Auditing Architecture Metadata](#auditing-architecture-metadata)).

### Category Field

Categories determine where tools appear on the [REMnux documentation site](https://docs.remnux.org). Format: `Main Category: Subcategory`

Examples:
- `Analyze Documents: PDF`
- `Examine Static Properties: PE Files`
- `Dynamically Reverse-Engineer Code: Scripts`
- `Gather and Analyze Data`

Multiple categories are comma-separated:
```yaml
# Category: Examine Static Properties: General, Perform Memory Forensics
```

### Tools Without Categories

Leave the `Category` field empty for:
- Internal dependencies (libraries used by other tools)
- Tools not meant for direct user interaction

These tools will not appear in the [public documentation](https://docs.remnux.org).

## init.sls Files

Each directory contains an `init.sls` file that includes all active state files in that directory.

```yaml
include:
  - remnux.python3-packages.oletools
  - remnux.python3-packages.volatility3
  # - remnux.python3-packages.deprecated-tool  # Commented = disabled
```

**Important**: When adding or removing a tool, update the corresponding `init.sls` file.

## Adding or Updating a Tool

1. Create or modify the `.sls` file in the appropriate directory
2. Add or update frontmatter with all required fields
3. Write the Salt states for installation
4. Test using `.ci/dev-state.sh` (see below)
5. Add the state to the directory's `init.sls` (if new)
6. Update documentation: `python3 .ci/update-docs.py path/to/tool.sls`

For detailed contribution guidelines, see [Contribute a Salt State File](https://docs.remnux.org/get-involved/add-or-update-tools/contribute-a-salt-state-file).

### Testing State Files

Use `dev-state.sh` to test a state file in a [minimal Docker container](https://github.com/REMnux/docker/tree/master/saltstack-tester):

```bash
# Launch the test container
.ci/dev-state.sh

# Inside the container, test your state (use dots instead of slashes, omit .sls)
salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls remnux.python3-packages.peframe
```

The container starts with a minimal Ubuntu system, ensuring your state file specifies all required dependencies.

## Removing a Tool

1. Remove or comment out the entry from `init.sls`
2. Delete the `.sls` file (or keep for reference)
3. Remove from documentation: `python3 .ci/update-docs.py --delete "Tool Name"`

## Documentation Management

The [REMnux documentation site](https://docs.remnux.org) syncs automatically from [github.com/REMnux/docs](https://github.com/REMnux/docs).

### Updating Documentation

Update docs after modifying a state file's frontmatter:

```bash
# Preview changes (dry run)
python3 .ci/update-docs.py path/to/tool.sls --dry-run --show-diff

# Apply changes
python3 .ci/update-docs.py path/to/tool.sls

# Delete a tool's documentation
python3 .ci/update-docs.py --delete "Tool Name"

# Regenerate the entries for every documented tool (review the diff first)
python3 .ci/update-docs.py --all --dry-run --show-diff
```

**Environment**: Set `GITHUB_ACCESS_TOKEN` for GitHub API, or ensure SSH access to `git@github.com:REMnux/docs.git`.

### Auditing Documentation

Compare state files against documentation to find discrepancies:

```bash
# Full audit
python3 .ci/audit-docs.py

# Show only issues
python3 .ci/audit-docs.py --issues-only

# Check a single state file
python3 .ci/audit-docs.py --check remnux/tools/capa.sls
```

The script exits with an error code when it finds errors. The audit identifies:
- **Errors**: Tools in state files missing from docs, architecture lines that differ from the state file
- **Warnings**: Tools in docs missing from state files, description/URL mismatches
- **Info**: Tools without categories (expected for dependencies)

### Auditing Architecture Metadata

`.ci/audit-arch.py` renders each documented state as amd64 and as arm64 in the `remnux/saltstack-tester` container without applying it. It then compares the result with the state's `Architecture` field. The [Audit architectures](.github/workflows/audit-arch.yml) workflow runs it on pushes and pull requests that change states.

```bash
# Audit every documented state (about 7 minutes)
python3 .ci/audit-arch.py

# Audit specific states
python3 .ci/audit-arch.py remnux.tools.trid remnux.packages.radare2
```

It reports an error when:
- The `Architecture` field disagrees with the render
- A state installs nothing on one architecture without a `Skipped on <arch>:` notification
- The two renders install different states, and `.ci/arch-acks.json` lacks an entry that lists exactly those differences with a reason
- A stub renders nothing on either architecture and lacks a `.ci/arch-acks.json` entry. Stubs include docs-only states and Jinja macro libraries. The entry names the state that provides the tool (`provider`) or asserts its architectures (`asserted`)

A render shows which states run, not whether the tool works. A package built without a feature, or a binary that fails at run time, passes the audit. Record those gaps in the `Arm64` or `Amd64` note.

## Issuing a Salt-States Release

For the REMnux installer to apply state file changes, a new salt-states release must be issued. Releases are signed with Cosign. The `release.sh` script automates the entire process:

```bash
export COSIGN_PASSWORD="..." GITHUB_TOKEN="..."
.ci/release.sh
```

The script:
1. Validates credentials and signing keys
2. Computes the next version tag (`vYYYY.W.R` format)
3. Creates and pushes the git tag
4. Runs Cast release with Cosign signatures

Version format: `vYYYY.W.R` where `YYYY` is the year, `W` is the week number, and `R` is the release number for that week (starting from `1`).

## CI Scripts

Scripts and configuration in the `.ci/` directory:

| File | Purpose |
|------|---------|
| `release.sh` | Full release automation: tag, sign, and upload |
| `frontmatter.py` | Shared frontmatter parser used by the scripts below |
| `lint-frontmatter.py` | Validate frontmatter (pre-commit hook) |
| `update-docs.py` | Sync state file frontmatter to documentation |
| `audit-docs.py` | Compare state files against documentation |
| `audit-arch.py` | Compare `Architecture` fields against amd64 and arm64 renders |
| `arch-acks.json` | Reviewed per-architecture differences for `audit-arch.py` |
| `dev-state.sh` | Launch a minimal container for interactive state testing |

---

For more information, visit [remnux.org](https://remnux.org).
