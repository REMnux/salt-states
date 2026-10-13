{% from "remnux/osarch.sls" import osarch with context %}
{% set fingerprint = "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3" %}
{% set key = "/etc/apt/keyrings/packages.mozilla.org.asc" %}

# Mozilla's APT repository for Firefox, set up as described in "Install
# Firefox on Linux" (support.mozilla.org/kb/install-firefox-linux). The key
# path and the file names match Mozilla's instructions, so a system configured
# by hand ends up with the same files.

remnux-mozilla-gpg:
  pkg.installed:
    - name: gpg

remnux-mozilla-key:
  file.managed:
    - name: {{ key }}
    - source: https://packages.mozilla.org/apt/repo-signing-key.gpg
    - skip_verify: True
    - makedirs: True
    - dir_mode: 755
    - mode: 644

# Runs on every apply, so a wrong key is never trusted on a later run. APT
# trusts every key in the file, so it must hold exactly one primary key, with
# Mozilla's fingerprint. On a mismatch, delete the key so the next run
# downloads it again. gpg needs a keyring home, so give it a throwaway one.
remnux-mozilla-key-fingerprint:
  cmd.run:
    - name: |
        echo "Mozilla's APT key at {{ key }} is not the single key with fingerprint {{ fingerprint }}. Deleting it." >&2
        rm -f {{ key }}
        exit 1
    - unless: |
        GNUPGHOME=$(mktemp -d)
        export GNUPGHOME
        keys=$(gpg --batch --with-colons -n -q --import --import-options import-show {{ key }})
        rc=$?
        rm -rf "$GNUPGHOME"
        [ $rc -eq 0 ] || exit 1
        [ "$(printf '%s\n' "$keys" | grep -c '^pub:')" -eq 1 ] || exit 1
        printf '%s\n' "$keys" | grep '^pub:' -A1 | grep -qx 'fpr:::::::::{{ fingerprint }}:'
    - require:
      - pkg: remnux-mozilla-gpg
      - file: remnux-mozilla-key

# Mozilla documents this one-line format for Ubuntu 24.04 and older. A leftover
# copy with a different signed-by path makes apt fail, so remove it.
remnux-mozilla-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/mozilla.list

remnux-mozilla-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/mozilla.sources
    - contents: |
        Types: deb
        URIs: https://packages.mozilla.org/apt
        Suites: mozilla
        Components: main
        Signed-By: {{ key }}
        Architectures: {{ osarch }}
    - require:
      - cmd: remnux-mozilla-key-fingerprint
      - file: remnux-mozilla-list-absent

# Prefer Mozilla's packages, and never install Ubuntu's firefox package, which
# is a transitional package that installs the Firefox snap.
remnux-mozilla-preferences:
  file.managed:
    - name: /etc/apt/preferences.d/mozilla
    - source: salt://remnux/repos/files/mozilla.preferences
    - require:
      - cmd: remnux-mozilla-key-fingerprint

# Refresh only while the package lists lack Mozilla's firefox, so later runs
# report no changes but a failed first download is retried.
remnux-mozilla-refresh:
  module.run:
    - name: pkg.refresh_db
    - unless: apt-cache madison firefox | grep -q packages.mozilla.org
    - require:
      - file: remnux-mozilla-repo
      - file: remnux-mozilla-preferences
