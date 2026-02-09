# Name: yara-x
# Website: https://github.com/VirusTotal/yara-x
# Description: Python bindings for YARA-X, the next generation of YARA written in Rust.
# Category: Gather and Analyze Data
# Author: Victor M. Alvarez, VirusTotal: https://github.com/VirusTotal
# License: BSD-3-Clause License: https://github.com/VirusTotal/yara-x/blob/main/LICENSE
# Notes: To use, run `/opt/yara-x/bin/python3` then `import yara_x`. Coexists with classic yara-python.

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-yara-x-venv:
  virtualenv.managed:
    - name: /opt/yara-x
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-yara-x:
  pip.installed:
    - name: yara-x
    - bin_env: /opt/yara-x/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-yara-x-venv
