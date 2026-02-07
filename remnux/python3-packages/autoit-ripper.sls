# Name: AutoIt-Ripper
# Website: https://github.com/nazywam/AutoIt-Ripper
# Description: Extract AutoIt scripts embedded in PE binaries.
# Category: Statically Analyze Code: Scripts
# Author: Michał Praszmo: https://x.com/nazywam
# License: MIT License: https://github.com/nazywam/AutoIt-Ripper/blob/master/LICENSE
# Notes: autoit-ripper

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-autoit-ripper-venv:
  virtualenv.managed:
    - name: /opt/autoit-ripper
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib_metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-autoit-ripper-install:
  pip.installed:
    - name: autoit-ripper
    - bin_env: /opt/autoit-ripper/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-autoit-ripper-venv

remnux-python3-packages-autoit-ripper-symlink:
  file.symlink:
    - name: /usr/local/bin/autoit-ripper
    - target: /opt/autoit-ripper/bin/autoit-ripper
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-autoit-ripper-install
