# Name: binee (Binary Emulation Environment)
# Website: https://github.com/carbonblack/binee
# Description: Analyze I/O operations of a suspicious PE file by emulating its execution.
# Category: Statically Analyze Code: PE Files
# Author: Carbon Black, Kyle Gwinnup, John Holowczak
# License: GNU General Public License (GPL) v2: https://github.com/carbonblack/binee/blob/master/LICENSE
# Notes: Before using this tool, place Windows 32-bit DLLs that your sample requires in /opt/binee-files/system32; check which DLLs you might need by examining the import table using the "-i" parameter.

include:
  - remnux.repos.remnux
  
binee:
  pkg.installed:
    - pkgrepo: remnux