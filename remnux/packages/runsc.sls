# Name: runsc
# Website: https://github.com/edygert/runsc
# Description: Run shellcode to trace and analyze its execution.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: Evan Dygert: https://x.com/edygert
# License: MIT License: https://github.com/edygert/runsc/blob/main/LICENSE
# Architecture: amd64
# Arm64: Use speakeasy or qiling instead.
# Notes: Use the `tracesc` command to execute runsc within Wine in a way that traces the execution of shellcode. WARNING! This wrapper will actually execute the shellcode on the system, which might lead to your system becoming infected. Only use this wrapper in a properly configured, isolated laboratory environment, which you can return to a pristine state at the end of your analysis.

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-packages-runsc-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: runsc is not available for this architecture."

{% else %}

include:
  - remnux.repos.remnux
  - remnux.packages.wine

remnux-packages-runsc:
  pkg.installed:
    - version: latest
    - upgrade: True
    - name: runsc
    - pkgrepo: remnux

{% endif %}
