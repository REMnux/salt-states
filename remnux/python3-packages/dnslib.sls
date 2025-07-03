# Name: dnslib
# Website: https://github.com/paulc/dnslib
# Description: Python library to encode/decode DNS wire-format packets
# Category: Gather and analyze data
# Author: Paul Chakravarti
# License: BSD 2-Clause "Simplified" License (https://github.com/paulc/dnslib/blob/master/LICENSE)
# Notes: Library - /opt/dnslib/bin/python3 - import dnslib

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-dnslib-venv:
  virtualenv.managed:
    - name: /opt/dnslib
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-dnslib:
  pip.installed:
    - name: dnslib
    - bin_env: /opt/dnslib/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-dnslib-venv
