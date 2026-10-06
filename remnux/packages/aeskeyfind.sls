# Name: AESKeyFinder
# Website: https://citp.princeton.edu/our-work/memory/
# Description: Find 128-bit and 256-bit AES keys in a memory image.
# Category: Perform Memory Forensics
# Author: Nadia Heninger, Alex Halderman
# License: Free, unknown license
# Notes: aeskeyfind

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-packages-aeskeyfind-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: AESKeyFinder is not available for this architecture."

{% else %}

aeskeyfind:
  pkg.installed

{% endif %}
