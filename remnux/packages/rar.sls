# Name: RAR
# Website: https://www.rarlab.com
# Description: Compress and decompress files using a variety of algorithms.
# Category: General Utilities
# Author: Alexander Roshal
# License: Shareware: "Anyone may use this software during a test period of 40 days. Following this test period of 40 days or less, if you wish to continue to use RAR, you must purchase a license." For details, see https://www.rarlab.com/license.htm.
# Notes: rar

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-packages-rar-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: RAR is not available for this architecture."

{% else %}

remnux-packages-rar:
  pkg.installed:
    - name: rar

{% endif %}
