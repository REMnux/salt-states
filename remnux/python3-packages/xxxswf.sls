# Name: xxxswf
# Website: https://github.com/viper-framework/xxxswf
# Description: Analyze Flash SWF files.
# Category: Statically Analyze Code: Flash
# Author: Alexander Hanel
# License: GNU General Public License (GPL) v3.0: https://github.com/viper-framework/xxxswf/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-dev
  - remnux.packages.build-essential
  - remnux.packages.git

remnux-python3-packages-xxxswf-venv:
  virtualenv.managed:
    - name: /opt/xxxswf
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - pylzma
      - yara-python
    - require:
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.python3-dev
      - sls: remnux.packages.build-essential

remnux-python3-packages-xxxswf:
  pip.installed:
    - name: git+https://github.com/viper-framework/xxxswf.git
    - bin_env: /opt/xxxswf/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-xxxswf-venv
      - sls: remnux.packages.git

remnux-python3-packages-xxxswf-symlink:
  file.symlink:
    - name: /usr/local/bin/xxxswf
    - target: /opt/xxxswf/bin/xxxswf
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-xxxswf
