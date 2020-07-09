# Name: InlineEgg-ng
# Website: https://www.coresecurity.com/core-labs/open-source-tools/inlineegg-cs
# Description: Python module for writing small assembly programs.
# Category: Dynamically Reverse-Engineer Code: Shellcode
# Author: Gerardo Richarte, maintained by evandrix
# License: Free for non-commercial use, custom license: https://github.com/radare/toys/blob/master/InlineEgg/LICENSE
# Notes: 

include:
  - remnux.packages.python-pip

InlineEgg-ng:
  pip.installed:
  - require:
    - sls: remnux.packages.python-pip
