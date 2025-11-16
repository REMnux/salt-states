# Name: Speakeasy
# Website: https://github.com/mandiant/speakeasy
# Description: Emulate code execution, including shellcode, Windows drivers, and Windows PE files.
# Category: Statically Analyze Code: PE Files, Dynamically Reverse-Engineer Code: Shellcode
# Author: FireEye Inc, Andrew Davis
# License: MIT License: https://github.com/mandiant/speakeasy/blob/master/LICENSE.txt
# Notes: To run the tool, use `speakeasy`, `emu_exe.py`, and `emu_dll.py` commands.

{% set tools = ["emu_exe.py", "emu_dll.py", "speakeasy"] %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-pip

{% if grains['oscodename'] != 'noble' %}
remnux-python3-packages-remove-speakeasy:
  pip.removed:
    - name: speakeasy
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip

{% endif %}

remnux-python3-packages-speakeasy-virtualenv:
  virtualenv.managed:
    - name: /opt/speakeasy
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib_metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.python3-pip
{% if grains['oscodename'] != 'noble' %}
      - pip: remnux-python3-packages-remove-speakeasy
{% endif %}

remnux-python3-packages-speakeasy:
  pip.installed:
    - name: speakeasy-emulator
    - bin_env: /opt/speakeasy/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-speakeasy-virtualenv

remnux-python3-packages-speakeasy-emuexe:
  file.managed:
    - name: /opt/speakeasy/bin/emu_exe.py
    - source: https://github.com/mandiant/speakeasy/raw/master/examples/emu_exe.py
    - source_hash: sha256=a02d5729e321426b1f5b1b199a82bc3b379af3e6839d017b8d06b0e85ee590da
    - makedirs: false
    - mode: 755
    - require:
      - pip: remnux-python3-packages-speakeasy

remnux-python3-packages-speakeasy-emuexe-shebang:
  file.prepend:
    - name: /opt/speakeasy/bin/emu_exe.py
    - text: '#!/opt/speakeasy/bin/python3'
    - require:
      - file: remnux-python3-packages-speakeasy-emuexe

remnux-python3-packages-speakeasy-emudll:
  file.managed:
    - name: /opt/speakeasy/bin/emu_dll.py
    - source: https://github.com/mandiant/speakeasy/raw/master/examples/emu_dll.py
    - source_hash: sha256=49c8bc0e85585985e01ea2f94111e6312455f22a286fc3fe6218badf10531f1f
    - makedirs: false
    - mode: 755
    - require:
      - pip: remnux-python3-packages-speakeasy

remnux-python3-packages-speakeasy-emudll-shebang:
  file.prepend:
    - name: /opt/speakeasy/bin/emu_dll.py
    - text: '#!/opt/speakeasy/bin/python3'
    - require:
      - file: remnux-python3-packages-speakeasy-emudll

remnux-python3-packages-old-speakeasy-wrapper:
  file.absent:
    - name: /opt/speakeasy/bin/run_speakeasy.py
    - require:
      - pip: remnux-python3-packages-speakeasy

{% for tool in tools %}
remnux-python3-packages-speakeasy-{{ tool }}-symlink:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/speakeasy/bin/{{ tool }}
    - makedirs: False
    - force: True
    - require:
      - pip: remnux-python3-packages-speakeasy
{% endfor %}
