# Name: Firefox
# Website: https://www.mozilla.org/firefox/
# Description: Web browser.
# Category: General Utilities
# Author: Mozilla Corporation
# License:  Mozilla Public License (MPL): https://www.mozilla.org/en-US/MPL/#source-code
# Notes: firefox

# Installs Firefox from Mozilla's APT repository. Ubuntu's firefox package is a
# transitional package that installs the Firefox snap. On systems that have it,
# this state replaces it with Mozilla's package, copies snap profiles to
# ~/.mozilla/firefox, and then removes the snap.

include:
  - remnux.repos.mozilla

# Salt treats the transitional package as an installed firefox, and its epoch
# makes it newer than Mozilla's versions, so purge it and install Mozilla's
# package in the same command. (Salt caches the package list during a run, so
# a separate pkg.installed would still see the purged package.) Download
# Mozilla's package first, so a failed download leaves the system unchanged.
# apt counts that download as a downgrade, because Mozilla's versions sort
# below Ubuntu's. --force-remove-reinstreq covers the half-installed state that
# a failed snap install leaves behind.
remnux-packages-firefox-ubuntu-purged:
  cmd.run:
    - name: |
        set -e
        apt-get update
        apt-get install -y --allow-downgrades --download-only firefox
        dpkg --purge --force-remove-reinstreq firefox
        apt-get install -y firefox
    - env:
      - DEBIAN_FRONTEND: noninteractive
    - onlyif:
      - dpkg-query -W -f='${Version}' firefox 2>/dev/null | grep -q snap
      - apt-cache madison firefox | grep -q packages.mozilla.org
    - require:
      - sls: remnux.repos.mozilla

firefox:
  pkg.installed:
    - refresh: True
    - require:
      - sls: remnux.repos.mozilla
      - cmd: remnux-packages-firefox-ubuntu-purged

# Copy the snap's profiles to ~/.mozilla/firefox and hand them to Mozilla's
# package, so nothing is lost when the snap goes. See the script for details.
remnux-packages-firefox-snap-profiles:
  cmd.script:
    - source: salt://remnux/packages/files/firefox-snap-profiles.sh
    - onlyif: snap list firefox
    - require:
      - pkg: firefox

# Remove the snap only once Mozilla's package is installed.
remnux-packages-firefox-snap-removed:
  cmd.script:
    - source: salt://remnux/packages/files/firefox-snap-remove.sh
    - onlyif:
      - snap list firefox
      - test -x /usr/lib/firefox/firefox
      - apt-cache policy firefox | grep -A1 '^ \*\*\* ' | grep -q packages.mozilla.org
    - require:
      - pkg: firefox
      - cmd: remnux-packages-firefox-snap-profiles
