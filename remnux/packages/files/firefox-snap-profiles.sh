#!/bin/bash
# Run by remnux.packages.firefox while the Firefox snap is still installed.
#
# Removing the snap deletes ~/snap/firefox, which holds the snap's profiles
# (bookmarks, history, preferences, extensions, saved logins). Copy them first,
# as Mozilla's instructions describe, to ~/.mozilla/firefox, or to
# ~/.mozilla/firefox-snap when ~/.mozilla/firefox already exists. The copy goes
# through a staging directory, so an interrupted copy is never mistaken for a
# finished one. Never copy a profile that the snap Firefox has open.
#
# Each Firefox installation claims a profile in an [Install<hash>] section of
# profiles.ini. Mozilla's package, installed in /usr/lib/firefox, uses the hash
# 4F96D1932A9F858E. Without a section of its own, it opens a new, empty
# profile, both when another installation locked the existing profile and when
# that profile was last used by another installation, as the snap's always is.
# So name the snap's profile in a section for Mozilla's package.
set -euo pipefail

readonly DEB_HASH=4F96D1932A9F858E

# Print the most recently modified of the profiles that awk program $2 prints
# from profiles.ini in $1.
newest_profile() {
    local dir=$1 program=$2 path mtime chosen="" newest=0
    while IFS= read -r path; do
        [[ -n "$path" && -d "$dir/$path" ]] || continue
        mtime=$(stat -c %Y "$dir/$path")
        if (( mtime > newest )); then
            newest=$mtime
            chosen=$path
        fi
    done < <(awk "$program" "$dir/profiles.ini")
    printf '%s' "$chosen"
}

# Print the profile that profiles.ini in $1 should give Mozilla's package: one
# that an [Install<hash>] section names, or else the default profile, or else
# any profile. Prefer the most recently used.
# shellcheck disable=SC2016 # The $ expressions are awk's, not the shell's.
snap_profile() {
    local dir=$1 profile
    # Each awk program prints the Path of matching profiles, one per line.
    local claimed='/^\[/ { claim = ($0 ~ /^\[Install/) } claim && sub(/^Default=/, "")'
    local default='/^\[/ { if (path != "" && dflt) print path; path = ""; dflt = 0 }
        /^Path=/ { path = substr($0, 6) } /^Default=1$/ { dflt = 1 }
        END { if (path != "" && dflt) print path }'
    local any='/^Path=/ { print substr($0, 6) }'
    for program in "$claimed" "$default" "$any"; do
        profile=$(newest_profile "$dir" "$program")
        if [[ -n "$profile" ]]; then
            printf '%s' "$profile"
            return
        fi
    done
}

# Replace the [Install<hash>] sections in the profiles copied to $1 with one
# for Mozilla's package that names profile $2.
hand_to_deb() {
    local dir=$1 profile=$2
    awk '/^\[/ { skip = ($0 ~ /^\[Install/) } !skip' "$dir/profiles.ini" > "$dir/profiles.ini.new"
    printf '\n[Install%s]\nDefault=%s\nLocked=1\n' "$DEB_HASH" "$profile" >> "$dir/profiles.ini.new"
    mv "$dir/profiles.ini.new" "$dir/profiles.ini"
    printf '[%s]\nDefault=%s\nLocked=1\n' "$DEB_HASH" "$profile" > "$dir/installs.ini"
}

for home in /root /home/*; do
    src="$home/snap/firefox/common/.mozilla/firefox"
    [[ -f "$src/profiles.ini" ]] || continue
    if [[ -e "$home/.mozilla/firefox/.remnux-from-snap" || -e "$home/.mozilla/firefox-snap/.remnux-from-snap" ]]; then
        continue
    fi
    dst="$home/.mozilla/firefox"
    if [[ -e "$dst" ]]; then
        dst="$home/.mozilla/firefox-snap"
    fi
    if [[ -e "$dst" ]]; then
        echo "Both $home/.mozilla/firefox and $dst exist. Move one of them, then run the REMnux installer again." >&2
        exit 1
    fi
    if pgrep -f '^/snap/firefox/' >/dev/null; then
        echo "Firefox (snap) is running. Close it, then run the REMnux installer again." >&2
        exit 1
    fi

    owner=$(stat -c '%u:%g' "$home")
    staging="$dst.remnux-partial"
    mkdir -p "$home/.mozilla"
    chown "$owner" "$home/.mozilla"
    rm -rf "$staging"
    cp -a "$src" "$staging"

    # Mozilla's package reads ~/.mozilla/firefox, not ~/.mozilla/firefox-snap.
    if [[ "$dst" == "$home/.mozilla/firefox" ]] && ! grep -qx "\[Install$DEB_HASH\]" "$staging/profiles.ini"; then
        profile=$(snap_profile "$staging")
        if [[ -n "$profile" ]]; then
            hand_to_deb "$staging" "$profile"
            echo "Firefox will open the $profile profile in $dst"
        fi
    fi

    touch "$staging/.remnux-from-snap"
    chown "$owner" "$staging/profiles.ini" "$staging/.remnux-from-snap"
    [[ ! -e "$staging/installs.ini" ]] || chown "$owner" "$staging/installs.ini"
    mv "$staging" "$dst"
    echo "Copied Firefox profiles from $src to $dst"
done
