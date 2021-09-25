# Name: Speakeasy
# Website: https://github.com/fireeye/speakeasy
# Description: Emulate code execution, including shellcode, Windows drivers, and Windows PE files.
# Category: Statically Analyze Code: PE Files, Dynamically Reverse-Engineer Code: Shellcode
# Author: FireEye Inc, Andrew Davis
# License: MIT License: https://github.com/fireeye/speakeasy/blob/master/LICENSE.txt
# Notes: run_speakeasy.py, emu_exe.py, emu_dll.py

include:
  - remnux.python3-packages.pip
  - remnux.packages.git

remnux-python3-packages-speakeasy-requirements:
  pip.installed:
    - bin_env: /usr/bin/python3
    - requirements: https://raw.githubusercontent.com/mandiant/speakeasy/master/requirements.txt
    - require:
      - sls: remnux.python3-packages.pip

remnux-python3-packages-speakeasy:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: git+https://github.com/mandiant/speakeasy.git@master
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.git
      - pip: remnux-python3-packages-speakeasy-requirements

remnux-python3-packages-speakeasy-wrapper:
  file.managed:
    - name: /usr/local/bin/run_speakeasy.py
    - source: https://raw.githubusercontent.com/mandiant/speakeasy/master/speakeasy/speakeasy.py
    - source_hash: sha256=6a5a3a9914f75bd53685664dd62a0c629c72685a3b2fbfebf45f00eb1bc0bced
    - makedirs: false
    - mode: 755
    - require:
      - pip: remnux-python3-packages-speakeasy

remnux-python3-packages-speakeasy-wrapper-shebang:
  file.prepend:
    - name: /usr/local/bin/run_speakeasy.py
    - text: '#!/usr/bin/env python3'
    - require:
      - file: remnux-python3-packages-speakeasy-wrapper

remnux-python3-packages-speakeasy-emuexe:
  file.managed:
    - name: /usr/local/bin/emu_exe.py
    - source: https://github.com/mandiant/speakeasy/raw/master/examples/emu_exe.py
    - source_hash: sha256=a02d5729e321426b1f5b1b199a82bc3b379af3e6839d017b8d06b0e85ee590da
    - makedirs: false
    - mode: 755
    - require:
      - pip: remnux-python3-packages-speakeasy

remnux-python3-packages-speakeasy-emuexe-shebang:
  file.prepend:
    - name: /usr/local/bin/emu_exe.py
    - text: '#!/usr/bin/env python3'
    - require:
      - file: remnux-python3-packages-speakeasy-emuexe

remnux-python3-packages-speakeasy-emudll:
  file.managed:
    - name: /usr/local/bin/emu_dll.py
    - source: https://github.com/mandiant/speakeasy/raw/master/examples/emu_dll.py
    - source_hash: sha256=49c8bc0e85585985e01ea2f94111e6312455f22a286fc3fe6218badf10531f1f
    - makedirs: false
    - mode: 755
    - require:
      - pip: remnux-python3-packages-speakeasy

remnux-python3-packages-speakeasy-emudll-shebang:
  file.prepend:
    - name: /usr/local/bin/emu_dll.py
    - text: '#!/usr/bin/env python3'
    - require:
      - file: remnux-python3-packages-speakeasy-emuexe
