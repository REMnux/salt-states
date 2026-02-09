# Name: LIEF
# Website: https://lief.re
# Description: Parse and analyze PE, ELF, MachO, DEX, OAT, VDEX, ART, and DWARF executable formats.
# Category: Examine Static Properties: General
# Author: Romain Thomas: https://github.com/romainthomas
# License: Apache License 2.0: https://github.com/lief-project/LIEF/blob/main/LICENSE
# Notes: To use, run `/opt/lief/bin/python3` then `import lief`. Use `lief.parse("sample")` to auto-detect format and extract imports, exports, sections, and signatures.

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-lief-venv:
  virtualenv.managed:
    - name: /opt/lief
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-lief:
  pip.installed:
    - name: lief
    - bin_env: /opt/lief/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-lief-venv
