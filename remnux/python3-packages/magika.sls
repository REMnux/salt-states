# Name: Magika
# Website: https://google.github.io/magika
# Description: Identify file type using signatures.
# Category: Examine Static Properties: General
# Author: Google
# License: Apache License 2.0: https://github.com/google/magika/blob/main/LICENSE
# Notes:

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-magika-venv:
  virtualenv.managed:
    - name: /opt/magika
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib_metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-magika-install:
  pip.installed:
    - name: magika
    - bin_env: /opt/magika/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-magika-venv

remnux-python3-packages-magika-symlink:
  file.symlink:
    - name: /usr/local/bin/magika
    - target: /opt/magika/bin/magika
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-magika-install
