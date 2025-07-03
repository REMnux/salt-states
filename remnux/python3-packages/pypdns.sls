# Name: PyPDNS
# Website: https://github.com/CIRCL/PyPDNS
# Description: Client API to query any Passive DNS implementation
# Category: 
# Author: CIRCL - Computer Incident Response Center Luxembourg
# License: Copyright / All Rights Reserved (https://github.com/CIRCL/PyPDNS/blob/main/LICENSE) 
# Notes: pdns

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-pypdns-venv:
  virtualenv.managed:
    - name: /opt/pypdns
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-pypdns:
  pip.installed:
    - name: pypdns
    - bin_env: /opt/pypdns/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-pypdns-venv

remnux-python3-package-pypdns-symlink:
  file.symlink:
    - name: /usr/local/bin/pdns
    - target: /opt/pypdns/bin/pdns
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-package-pypdns
