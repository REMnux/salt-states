# Name: AIDebug
# Website: https://github.com/anpa1200/AIDebug
# Description: AI-assisted malware reverse-engineering debugger with ATT&CK, YARA, IOC, JSON, and analyst report output.
# Category: Statically Analyze Code: General, Use Artificial Intelligence
# Author: Andrey Pautov: https://1200km.com
# License: MIT: https://github.com/anpa1200/AIDebug/blob/main/LICENSE
# Notes: To run the tool, use the command "aidebug". Add --offline to keep analysis local. Otherwise it sends sample data to the LLM provider whose API key is set in the environment.

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
    - name: 1200km-aidebug[ai]
    - bin_env: /opt/aidebug/bin/python3
    - upgrade: True
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
