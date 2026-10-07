# Name: AIDebug
# Website: https://github.com/anpa1200/AIDebug
# Description: AI-assisted malware reverse-engineering debugger with ATT&CK, YARA, IOC, JSON, and analyst report output.
# Category: Dynamically Reverse-Engineer Code: General
# Author: Andrey Pautov: https://1200km.com
# License: MIT: https://github.com/anpa1200/AIDebug/blob/main/LICENSE
# Notes: aidebug

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-aidebug-venv:
  virtualenv.managed:
    - name: /opt/aidebug
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-aidebug:
  pip.installed:
    - name: 1200km-aidebug==3.0.0
    - bin_env: /opt/aidebug/bin/python3
    - upgrade: False
    - require:
      - virtualenv: remnux-python3-packages-aidebug-venv

remnux-python3-packages-aidebug-symlink:
  file.symlink:
    - name: /usr/local/bin/aidebug
    - target: /opt/aidebug/bin/aidebug
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-aidebug
