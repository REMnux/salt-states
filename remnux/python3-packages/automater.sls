# Name: Automater
# Website: https://github.com/digitalsleuth/TekDefense-Automater
# Description: Gather OSINT data about IPs, domains, and hashes.
# Category: Gather and Analyze Data
# Author: 1aN0rmus and digitalsleuth
# License: MIT License: https://github.com/digitalsleuth/TekDefense-Automater/blob/master/LICENSE
# Notes: automater

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.git

remnux-python3-package-automater-venv:
  virtualenv.managed:
    - name: /opt/automater
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-automater:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/TekDefense-Automater
    - bin_env: /opt/automater/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-automater-venv
      - sls: remnux.packages.git

remnux-python3-package-automater-symlink:
  file.symlink:
    - name: /usr/local/bin/automater
    - target: /opt/automater/bin/automater
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-package-automater
