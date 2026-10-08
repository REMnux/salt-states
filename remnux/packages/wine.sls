# Name: Wine
# Website: https://www.winehq.org
# Description: Run Windows applications.
# Category: Dynamically Reverse-Engineer Code: General, General Utilities
# Author: https://wiki.winehq.org/Acknowledgements
# License: GNU Lesser General Public License (LGPL) v2.1 or later: https://wiki.winehq.org/Licensing
# Architecture: amd64
# Arm64: No alternative identified. Hangover, which combines Wine with FEX or Box64, is an experimental option outside REMnux.
# Notes: wine

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-packages-wine-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: Wine is not available for this architecture."

{% else %}

include:
  - remnux.repos.winehq

remnux-packages-wine-i386-architecture:
  cmd.run:
    - name: dpkg --add-architecture i386 && apt-get update
    - unless: dpkg --print-foreign-architectures | grep -q i386

remnux-packages-wine-i386-deps:
  cmd.run:
    - name: apt-get install -y libc6:i386 libstdc++6:i386 libncurses6:i386 zlib1g:i386 --install-recommends
    - unless: dpkg -l | grep -q "ii  libncurses6:i386" && dpkg -l | grep -q "ii  zlib1g:i386"
    - require:
      - cmd: remnux-packages-wine-i386-architecture

remnux-packages-wine:
  pkg.installed:
    - name: winehq-stable
    - require:
      - cmd: remnux-packages-wine-i386-deps
      - sls: remnux.repos.winehq

{% endif %}
