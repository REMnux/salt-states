# Name: pypssl
# Website: https://github.com/adulau/crl-monitor/tree/master/client
# Description: Client API for PSSL
# Category: 
# Author: Alexandre Dulaunoy
# License: Copyright / All Rights Reserved (https://github.com/adulau/crl-monitor/blob/master/client/LICENSE)
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-pypssl-venv:
  virtualenv.managed:
    - name: /opt/pypssl
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-pypssl:
  pip.installed:
    - name: pypssl
    - bin_env: /opt/pypssl/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-pypssl-venv

remnux-python3-package-pypssl-symlink:
  file.symlink:
    - name: /usr/local/bin/pypssl
    - target: /opt/pypssl/bin/pypssl
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-package-pypssl
