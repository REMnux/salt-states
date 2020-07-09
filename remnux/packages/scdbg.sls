# Name: scdbg
# Website: http://sandsprite.com/blogs/index.php?uid=7&pid=152
# Description: Analyze shellcode by emulating its execution.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: David Zimmer
# License: Free, unknown license
# Notes: scdbg (GUI), scdbgc (console)

include:
  - remnux.repos.remnux
  - remnux.packages.wine
  
scdbg:
  pkg.installed:
    - pkgrepo: remnux