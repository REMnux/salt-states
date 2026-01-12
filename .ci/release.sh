#!/bin/bash
#
# Cast Release Script for REMnux
#
# Usage:
#   export COSIGN_PASSWORD="..." PGP_PASSWORD="..." GITHUB_TOKEN="..."
#   export CLOUDFLARE_API_TOKEN="..." CLOUDFLARE_ACCOUNT_ID="..."
#   .ci/release.sh
#
# Requirements:
#   - cast v1.0.0+
#   - cosign v2.x or v3.x (script auto-detects; Cast v1.0.0 may need updating for v3.x)
#   - gpg, git, jq, curl, shasum, python3, npx
#
# This script:
#   1. Checks that required binaries are installed
#   2. Validates that required environment variables are set
#   3. Checks that signing key files exist
#   4. Tests that the signing passwords are correct
#   5. Computes the next version tag (vYYYY.W.R format)
#   6. Creates and pushes the git tag
#   7. Runs cast release (for Cast users)
#   8. Uploads legacy GPG-signed files (for remnux-cli users)
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$REPO_ROOT"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_error() { echo -e "${RED}ERROR: $1${NC}" >&2; }
echo_success() { echo -e "${GREEN}$1${NC}"; }
echo_info() { echo -e "${YELLOW}$1${NC}"; }

# Upload a file to a GitHub release, with error checking
upload_asset() {
    local file_path="$1"
    local asset_name="$2"
    local response
    
    response=$(curl -s -X POST -H "Authorization: token ${GITHUB_TOKEN}" \
        -H "Content-Type: application/octet-stream" \
        "https://uploads.github.com/repos/REMnux/salt-states/releases/${RELEASE_ID}/assets?name=${asset_name}" \
        --data-binary "@${file_path}")
    
    if echo "$response" | jq -e '.id' > /dev/null 2>&1; then
        return 0
    else
        echo_error "Failed to upload ${asset_name}: $(echo "$response" | jq -r '.message // "Unknown error"')"
        return 1
    fi
}

# Step 1: Check required binaries
echo_info "==> Checking required binaries..."

for cmd in cast cosign gpg git jq curl shasum python3 npx; do
    if ! command -v "$cmd" &> /dev/null; then
        echo_error "$cmd is not installed or not in PATH"
        exit 1
    fi
done

# Detect Cosign version
COSIGN_VERSION=$(cosign version 2>&1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1)
COSIGN_MAJOR=$(echo "$COSIGN_VERSION" | cut -d. -f1 | tr -d 'v')

# Warn about Cast compatibility with Cosign v3.x
if [ "$COSIGN_MAJOR" -ge 3 ] 2>/dev/null; then
    echo -e "${YELLOW}WARNING: Cosign $COSIGN_VERSION detected.${NC}"
    echo -e "${YELLOW}Cast v1.0.0 may be incompatible with Cosign v3.x.${NC}"
    echo -e "${YELLOW}If cast release fails, downgrade to Cosign v2.4.1:${NC}"
    echo "  curl -Lo /usr/local/bin/cosign https://github.com/sigstore/cosign/releases/download/v2.4.1/cosign-darwin-amd64"
    echo "  chmod +x /usr/local/bin/cosign"
    echo ""
fi

echo_success "Required binaries found (Cosign $COSIGN_VERSION)"

# Step 2: Check required environment variables
echo_info "==> Checking environment variables..."

# Use ${VAR+x} to check if variable is set (even if empty)
if [ -z "${COSIGN_PASSWORD+x}" ]; then
    echo_error "COSIGN_PASSWORD environment variable is not set"
    echo "Usage:"
    echo "  export COSIGN_PASSWORD=\"...\" PGP_PASSWORD=\"...\" GITHUB_TOKEN=\"...\""
    echo "  .ci/release.sh"
    exit 1
fi

if [ -z "${PGP_PASSWORD+x}" ]; then
    echo_error "PGP_PASSWORD environment variable is not set"
    echo "Usage:"
    echo "  export COSIGN_PASSWORD=\"...\" PGP_PASSWORD=\"...\" GITHUB_TOKEN=\"...\""
    echo "  .ci/release.sh"
    exit 1
fi

if [ -z "${GITHUB_TOKEN+x}" ] || [ -z "$GITHUB_TOKEN" ]; then
    echo_error "GITHUB_TOKEN environment variable is not set or empty"
    echo "Create a token at: https://github.com/settings/tokens"
    echo "Required scope: repo (or public_repo)"
    echo "Usage:"
    echo "  export COSIGN_PASSWORD=\"...\" PGP_PASSWORD=\"...\" GITHUB_TOKEN=\"...\""
    echo "  .ci/release.sh"
    exit 1
fi

echo_success "Environment variables are set"

# Step 3: Check required files exist
echo_info "==> Checking required files..."

if [ ! -f "cosign.key" ]; then
    echo_error "cosign.key not found in repository root"
    exit 1
fi

if [ ! -f "pgp.key" ]; then
    echo_error "pgp.key not found in repository root"
    exit 1
fi

echo_success "Required key files found"

# Step 4: Validate Cosign password
echo_info "==> Validating Cosign password..."

# Use version-appropriate syntax for Cosign password validation
if [ "$COSIGN_MAJOR" -ge 3 ] 2>/dev/null; then
    # Cosign v3.x: Use --bundle flag (new bundle format)
    COSIGN_TEST_BUNDLE=$(mktemp)
    if ! echo "test" | cosign sign-blob --key cosign.key --yes --bundle "$COSIGN_TEST_BUNDLE" - > /dev/null 2>&1; then
        rm -f "$COSIGN_TEST_BUNDLE"
        echo_error "Cosign password is incorrect or cosign.key is invalid"
        exit 1
    fi
    rm -f "$COSIGN_TEST_BUNDLE"
else
    # Cosign v2.x: Use --output-signature and --tlog-upload=false
    if ! echo "test" | cosign sign-blob --key cosign.key --yes --output-signature /dev/null --tlog-upload=false - > /dev/null 2>&1; then
        echo_error "Cosign password is incorrect or cosign.key is invalid"
        exit 1
    fi
fi

echo_success "Cosign password validated"

# Step 5: Validate PGP password
echo_info "==> Validating PGP password..."

# Get the key ID from pgp.key
PGP_KEY_ID=$(gpg --show-keys --keyid-format long pgp.key 2>/dev/null | grep -E "^sec" | awk '{print $2}' | cut -d'/' -f2)

if [ -z "$PGP_KEY_ID" ]; then
    echo_error "Could not determine PGP key ID from pgp.key"
    exit 1
fi

# Import the key if not already in keyring
gpg --import pgp.key 2>/dev/null || true

# Test signing with the PGP key
if ! echo "test" | gpg --batch --yes --passphrase "$PGP_PASSWORD" --pinentry-mode loopback -u "$PGP_KEY_ID" --detach-sign - > /dev/null 2>&1; then
    echo_error "PGP password is incorrect or pgp.key is invalid"
    exit 1
fi

echo_success "PGP password validated"

# Step 6: Compute the next version tag
echo_info "==> Computing next version tag..."

YEAR=$(date +%Y)
WEEK=$(date +%-V)

# Find the highest release number for this week
EXISTING_TAGS=$(git tag -l "v${YEAR}.${WEEK}.*" 2>/dev/null | sed 's/.*\.//' | sort -n | tail -1)

if [ -z "$EXISTING_TAGS" ]; then
    RELEASE_NUM=1
else
    RELEASE_NUM=$((EXISTING_TAGS + 1))
fi

TAG="v${YEAR}.${WEEK}.${RELEASE_NUM}"

echo_success "Next version tag: $TAG"

# Step 7: Update VERSION file and create tag
VERSION_FILE="remnux/VERSION"
if [ -f "$VERSION_FILE" ] && [ "$(cat "$VERSION_FILE")" != "$TAG" ]; then
    echo_info "==> Updating VERSION file..."
    echo "$TAG" > "$VERSION_FILE"
    git add "$VERSION_FILE"
    git commit -m "Updating VERSION to $TAG"
    git push origin master
fi

echo_info "==> Creating git tag..."
git tag "$TAG"

echo_info "==> Pushing tag to origin..."
git push origin --tags

echo_success "Tag $TAG pushed to origin"

# Step 8: Run cast release
echo_info "==> Running cast release..."
CHECKPOINT_DISABLE=1 cast release --rm-dist

echo_success "Cast release completed"

# Step 9: Upload legacy GPG-signed files for remnux-cli compatibility
echo_info "==> Uploading legacy GPG-signed files for remnux-cli..."

# Get the release ID
RELEASE_ID=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" \
    "https://api.github.com/repos/REMnux/salt-states/releases/tags/${TAG}" | jq -r '.id')

if [ "$RELEASE_ID" == "null" ] || [ -z "$RELEASE_ID" ]; then
    echo_error "Could not find release ID for tag $TAG"
    exit 1
fi

# Create temp directory for artifacts
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"; rm -f "/tmp/remnux-salt-states-${TAG}.tar.gz"' EXIT

# Download the tarball from GitHub (to /tmp to match legacy format)
echo_info "    Downloading tarball..."
curl -sL -o "/tmp/remnux-salt-states-${TAG}.tar.gz" \
    "https://github.com/REMnux/salt-states/archive/${TAG}.tar.gz"

# Generate SHA256 checksum (with /tmp path to match remnux-cli expectations)
echo_info "    Generating SHA256 checksum..."
shasum -a 256 "/tmp/remnux-salt-states-${TAG}.tar.gz" > "${TEMP_DIR}/remnux-salt-states-${TAG}.tar.gz.sha256"

# GPG sign the checksum (clearsign)
echo_info "    GPG signing checksum..."
gpg --batch --yes --passphrase "$PGP_PASSWORD" --pinentry-mode loopback \
    --armor --clearsign --digest-algo SHA256 -u "$PGP_KEY_ID" \
    "${TEMP_DIR}/remnux-salt-states-${TAG}.tar.gz.sha256"

# GPG sign the tarball (detached signature)
echo_info "    GPG signing tarball..."
gpg --batch --yes --passphrase "$PGP_PASSWORD" --pinentry-mode loopback \
    --armor --detach-sign -u "$PGP_KEY_ID" \
    "/tmp/remnux-salt-states-${TAG}.tar.gz"

# Move the tarball signature to temp dir
mv "/tmp/remnux-salt-states-${TAG}.tar.gz.asc" "${TEMP_DIR}/"

# Upload the SHA256 checksum
echo_info "    Uploading SHA256 checksum..."
upload_asset "${TEMP_DIR}/remnux-salt-states-${TAG}.tar.gz.sha256" "remnux-salt-states-${TAG}.tar.gz.sha256"

# Upload the signed checksum (.asc)
echo_info "    Uploading signed checksum..."
upload_asset "${TEMP_DIR}/remnux-salt-states-${TAG}.tar.gz.sha256.asc" "remnux-salt-states-${TAG}.tar.gz.sha256.asc"

# Upload the tarball signature (.asc)
echo_info "    Uploading tarball signature..."
upload_asset "${TEMP_DIR}/remnux-salt-states-${TAG}.tar.gz.asc" "remnux-salt-states-${TAG}.tar.gz.asc"

echo_success "Legacy GPG files uploaded"

# =============================================================================
# Step: Generate and upload MCP search index (optional)
# =============================================================================
echo ""
echo_info "==> Generating MCP search index..."

# Generate the index
python3 "${SCRIPT_DIR}/generate-mcp-index.py" \
    --states-dir="${REPO_ROOT}" \
    --output="${TEMP_DIR}/search-index.json" \
    --site-name="REMnux Documentation" \
    --site-domain="docs.remnux.org" \
    --site-description="Searchable documentation for REMnux malware analysis tools" \
    --tool-prefix="remnux"

if [ -f "${TEMP_DIR}/search-index.json" ]; then
    echo_success "MCP search index generated"

    # Upload to R2 bucket (if Cloudflare credentials are configured)
    if [ -n "${CLOUDFLARE_API_TOKEN:-}" ] && [ -n "${CLOUDFLARE_ACCOUNT_ID:-}" ]; then
        echo_info "    Uploading to R2..."
        CLOUDFLARE_API_TOKEN="$CLOUDFLARE_API_TOKEN" \
        CLOUDFLARE_ACCOUNT_ID="$CLOUDFLARE_ACCOUNT_ID" \
        npx wrangler r2 object put remnux-docs-mcp-data/search-index.json \
            --file="${TEMP_DIR}/search-index.json" \
            --content-type=application/json \
            --remote
        echo_success "MCP search index uploaded to R2"
    else
        echo_info "    CLOUDFLARE_API_TOKEN or CLOUDFLARE_ACCOUNT_ID not set, skipping R2 upload"
        echo_info "    To upload manually, set these environment variables and re-run"
    fi
else
    echo_info "    MCP index generation skipped or failed"
fi

echo ""
echo_success "============================================"
echo_success "Release $TAG completed successfully!"
echo_success "============================================"
echo ""
echo "Release includes:"
echo "  - Cast/Cosign signed artifacts (for Cast users)"
echo "  - GPG signed artifacts (for remnux-cli users)"
echo "  - MCP search index (if Cloudflare credentials were set)"

