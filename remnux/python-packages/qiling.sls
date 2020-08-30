# Name: Qiling
# Website: https://www.qiling.io
# Description: Emulate code execution of PE files, shellcode, etc. for a variety of OS and hardware platforms.
# Category: Statically Analyze Code: General, Dynamically Reverse-Engineer Code: Shellcode
# Author: https://github.com/qilingframework/qiling/blob/master/AUTHORS.TXT
# License: GNU General Public License (GPL) v2.0: https://github.com/qilingframework/qiling/blob/master/COPYING
# Notes: Use `qltool` to analyze artifacts. Before analyzing Windows artifacts, gather Windows DLLs and other components using the [dllscollector.bat](https://github.com/qilingframework/qiling/blob/master/examples/scripts/dllscollector.bat) script. Read the tool's [documentation](https://docs.qiling.io) to get started.

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-python-packages-qiling:
  pip.installed:
    - name: qiling
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip