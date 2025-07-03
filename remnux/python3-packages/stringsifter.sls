# Name: StringSifter
# Website: https://github.com/mandiant/stringsifter
# Description: Automatically rank strings based on their relevance to the analysis of suspicious Windows executables.
# Category: Examine Static Properties: PE Files
# Author: FireEye Inc.
# License: Apache License 2.0: https://github.com/mandiant/stringsifter/blob/master/LICENSE
# Notes: flarestrings

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-dev

remnux-python3-packages-stringsifter-venv:
  virtualenv.managed:
    - name: /opt/stringsifter
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-stringsifter:
  pip.installed:
    - name: stringsifter
    - bin_env: /opt/stringsifter/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-stringsifter-venv
      - sls: remnux.packages.python3-dev

remnux-python3-packages-stringsifter-symlink:
  file.symlink:
    - name: /usr/local/bin/flarestrings
    - target: /opt/stringsifter/bin/flarestrings
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-stringsifter
