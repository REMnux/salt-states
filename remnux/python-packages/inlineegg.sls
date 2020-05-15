# Name: InlineEgg-ng
# Website: https://www.coresecurity.com/corelabs-research/open-source-tools/inlineegg
# Description: Python module to write assembly programs
# Category: Examine document files: Shellcode
# Author: Gerardo Richarte (maintained by evandrix)
# License: Custom license (free for noncommercial use)
# Notes: 

include:
  - remnux.packages.python-pip

InlineEgg-ng:
  pip.installed:
  - require:
    - sls: remnux.packages.python-pip
