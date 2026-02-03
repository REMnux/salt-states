# Name: pcode2code
# Website: https://github.com/Big5-sec/pcode2code
# Description: Decompile VBA macro p-code from Microsoft Office documents.
# Category: Analyze Documents: Microsoft Office
# Author: Nicolas Zilio: https://x.com/Big5_sec
# License: GNU General Public License (GPL) v3: https://github.com/Big5-sec/pcode2code/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-pcode2code-venv:
  virtualenv.managed:
    - name: /opt/pcode2code
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-pcode2code:
  pip.installed:
    - name: pcode2code
    - bin_env: /opt/pcode2code/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-pcode2code-venv

remnux-python3-packages-pcode2code-symlink:
  file.symlink:
    - name: /usr/local/bin/pcode2code
    - target: /opt/pcode2code/bin/pcode2code
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-pcode2code
