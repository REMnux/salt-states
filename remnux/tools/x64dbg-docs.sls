# Name: x64dbg Documentation
# Website: https://github.com/x64dbg/docs
# Description: Read the official x64dbg documentation offline, including the command reference and format specifiers.
# Category: Dynamically Reverse-Engineer Code: General
# Author: x64dbg contributors: https://github.com/x64dbg
# License: MIT License: https://github.com/x64dbg/docs/blob/master/LICENSE
# Notes: The documentation is in /usr/local/share/x64dbg-docs. It refreshes every time you run `remnux install`, so you can look up x64dbg command syntax without internet access.

{% set docs = '/usr/local/share/x64dbg-docs' %}
{% set staging = '/usr/local/share/.x64dbg-docs.staging' %}
{% set source = 'https://github.com/x64dbg/docs/archive/refs/heads/master.tar.gz' %}

include:
  - remnux.packages.curl

# Upstream ships the documentation as a git repository with no releases and no
# published checksum, so there is no hash for file.managed to pin and no version
# to bump. The snapshot is refetched on every run to keep it current, and the
# tarball is used instead of git.latest so the installed tree carries no .git
# directory.
#
# The download and extraction happen in a staging directory next to the target,
# which is on the same filesystem. The tree is moved into place only after the
# fetch, the extraction, and a sanity check on the extracted contents all
# succeed, so a failed or interrupted refresh leaves the previously installed
# documentation untouched. Replacing the whole tree also drops files that
# upstream has deleted, which an in-place extraction would leave behind forever.
remnux-tools-x64dbg-docs:
  cmd.run:
    - name: |
        set -e
        rm -rf {{ staging }}
        mkdir -p {{ staging }}/tree
        curl -fsSL --retry 3 -o {{ staging }}/docs.tar.gz {{ source }}
        tar -xzf {{ staging }}/docs.tar.gz -C {{ staging }}/tree --strip-components=1
        test -f {{ staging }}/tree/introduction/Formatting.md
        test -f {{ staging }}/tree/LICENSE
        test -d {{ staging }}/tree/licenses
        chown -R root:root {{ staging }}/tree
        find {{ staging }}/tree -type d -exec chmod 755 {} +
        find {{ staging }}/tree -type f -exec chmod 644 {} +
        rm -rf {{ docs }}
        mv {{ staging }}/tree {{ docs }}
        rm -rf {{ staging }}
    - require:
      - sls: remnux.packages.curl
