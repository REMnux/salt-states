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
| `Notes` | No | Command names, usage tips, compatibility notes |

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
```

**Environment**: Set `GITHUB_ACCESS_TOKEN` for GitHub API, or ensure SSH access to `git@github.com:REMnux/docs.git`.

### Auditing Documentation

Compare state files against documentation to find discrepancies:

```bash
# Full audit
python3 .ci/audit-docs.py

# Show only issues
python3 .ci/audit-docs.py --issues-only

# Exit with error code if issues found (for CI)
python3 .ci/audit-docs.py --check
```

The audit identifies:
- **Errors**: Tools in state files missing from docs
- **Warnings**: Tools in docs missing from state files, description/URL mismatches
- **Info**: Tools without categories (expected for dependencies)

## Issuing a Salt-States Release

For the REMnux installer to apply state file changes, a new salt-states release must be issued. Releases are signed with both Cosign and PGP keys. The `release.sh` script automates the entire process:

```bash
export COSIGN_PASSWORD="..." PGP_PASSWORD="..." GITHUB_TOKEN="..."
.ci/release.sh
```

The script:
1. Validates credentials and signing keys
2. Computes the next version tag (`vYYYY.W.R` format)
3. Creates and pushes the git tag
4. Runs Cast release with Cosign signatures
5. Uploads GPG-signed artifacts for remnux-cli compatibility

Version format: `vYYYY.W.R` where `YYYY` is the year, `W` is the week number, and `R` is the release number for that week (starting from `1`).

## CI Scripts

Scripts and configuration in the `.ci/` directory:

| File | Purpose |
|------|---------|
| `manifest.yml` | [Cast](https://github.com/ekristen/cast) distro config: defines modes, supported OSes, messages |
| `release.sh` | Full release automation: tag, sign, and upload |
| `update-docs.py` | Sync state file frontmatter to documentation |
| `audit-docs.py` | Compare state files against documentation |
| `dev-state.sh` | Launch a minimal container for interactive state testing |

---

For more information, visit [remnux.org](https://remnux.org).
