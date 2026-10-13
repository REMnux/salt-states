#!/bin/bash
# Run by remnux.packages.firefox once Mozilla's Firefox package is installed.
#
# snapd deletes the data directories of installed revisions and then the
# ~/snap/firefox directory itself. A directory left behind by an older revision
# makes that fail, and snapd then rolls back the removal. Delete those first.
set -euo pipefail

list=$(snap list --all firefox)
revs=$(awk 'NR > 1 && $3 ~ /^[0-9]+$/ { print $3 }' <<<"$list")
if [[ -z "$revs" ]]; then
    echo "Could not read the installed Firefox snap revisions" >&2
    exit 1
fi

for dir in /root/snap/firefox/* /home/*/snap/firefox/*; do
    [[ -d "$dir" && ! -L "$dir" ]] || continue
    rev=${dir##*/}
    [[ "$rev" =~ ^[0-9]+$ ]] || continue
    if ! grep -qx "$rev" <<<"$revs"; then
        echo "Removing $dir, left by Firefox snap revision $rev"
        rm -rf "$dir"
    fi
done

snap remove firefox
