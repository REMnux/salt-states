# Name: Speakeasy
# Website: https://github.com/fireeye/speakeasy
# Description: Emulate code execution, including shellcode, Windows drivers, and Windows PE files.
# Category: PE Files: Statically Analyze Code
# Author: FireEye Inc, Andrew Davis
# License: MIT License: https://github.com/fireeye/speakeasy/blob/master/LICENSE.txt
# Notes: run_speakeasy.py

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.git

remnux-python-packages-speakeasy-requirements:
  pip.installed:
    - bin_env: /usr/bin/python3
    - requirements: https://raw.githubusercontent.com/fireeye/speakeasy/master/requirements.txt
    - require:
      - sls: remnux.packages.python3-pip

remnux-python-packages-speakeasy:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: git+https://github.com/fireeye/speakeasy.git@master
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.git
      - pip: remnux-python-packages-speakeasy-requirements

remnux-python-packages-speakeasy-wrapper:
  file.managed:
    - name: /usr/local/bin/run_speakeasy.py
    - source: https://raw.githubusercontent.com/fireeye/speakeasy/master/run_speakeasy.py
    - source_hash: sha256=fddca5fb77fcafada3ee5469d6f0e2b7ea8cbb0ebe879114a2d83fa6746f0720
    - makedirs: false
    - mode: 755
    - require:
      - pip: remnux-python-packages-speakeasy

remnux-python-packages-speakeasy-wrapper-shebang:
  file.replace:
    - name: /usr/local/bin/run_speakeasy.py
    - pattern: '#!/usr/bin/env python3'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: True
    - backup: false
    - count: 1
    - require:
      - file: remnux-python-packages-speakeasy-wrapper