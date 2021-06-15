# Name: runsc
# Website: https://github.com/edygert/runsc
# Description: Run shellcode to trace and analyze its execution.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: Evan Dygert
# License: MIT License: https://github.com/edygert/runsc/blob/main/LICENSE
# Notes: Use the `tracert` command to execute runsc within Wine in a way that traces the execution of shellcode. WARNING! This wrapper will actually execute the shellcode on the system, which might lead to your system becoming infected. Only use this wrapper in an properly configured, isolated laboratory environment, which you can return to a pristine state at the end of your analysis.


include:
  - remnux.repos.remnux
  - remnux.packages.wine

remnux-packages-runsc:
  pkg.installed:
    - version: latest
    - upgrade: True
    - name: runsc
    - pkgrepo: remnux