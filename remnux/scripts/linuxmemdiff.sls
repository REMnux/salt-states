# Name: linux_mem_diff_tool
# Website: https://github.com/monnappa22/linux_mem_diff_tool
# Description: Compare two memory images of Linux systems by using Volatility.
# Category: Perform Memory Forensics
# Author: Monnappa K A
# License: Free, unknown license
# Notes: linux_mem_diff.py

include:
  - remnux.python-packages.volatility

remnux-linuxmemdiff-source:
  file.managed:
    - name: /usr/local/bin/linux_mem_diff.py
    - source: https://github.com/monnappa22/linux_mem_diff_tool/raw/master/linux_mem_diff.py
    - source_hash: sha256=7e0f5dc793e3611eca50a5561bf19a6d8a7e1ad5edfeec66bccdb2aff5395fb2
    - mode: 755

remnux-linuxmemdiff-shebang:
  file.replace:
    - name: /usr/local/bin/linux_mem_diff.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/usr/bin/env python'
    - prepend_if_not_found: True
    - count: 1
    - require:
      - file: remnux-linuxmemdiff-source
    - watch:
      - file: remnux-linuxmemdiff-source

remnux-linuxmemdiff-python-path:
  file.replace:
    - name: /usr/local/bin/linux_mem_diff.py
    - pattern: "python_path = r''"
    - repl: "python_path = r'/usr/bin/python'"
    - count: 1
    - require:
      - file: remnux-linuxmemdiff-source
    - watch:
      - file: remnux-linuxmemdiff-shebang

remnux-linuxmemdiff-vol-path:
  file.replace:
    - name: /usr/local/bin/linux_mem_diff.py
    - pattern: "vol_path = r''"
    - repl: "vol_path = r'/usr/local/bin/vol.py'"
    - count: 1
    - require:
      - file: remnux-linuxmemdiff-source
    - watch:
      - file: remnux-linuxmemdiff-python-path
