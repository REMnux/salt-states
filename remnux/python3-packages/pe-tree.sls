# Name: PE Tree
# Website: https://github.com/blackberry/pe_tree
# Description: Examine contents and structure of PE files.
# Category: Examine Static Properties: PE Files
# Author: BlackBerry Limited: https://x.com/BlackBerrySpark and Tom Bonner: https://x.com/thomas_bonner
# License: Apache License 2.0: https://github.com/blackberry/pe_tree/blob/master/LICENSE
# Notes: pe-tree

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}
{# PyQt5 publishes no arm64 wheel, so arm64 uses Ubuntu's python3-pyqt5 through a venv that
   sees system packages, and installs pe_tree's other dependencies explicitly. #}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-pyqt5
  - remnux.packages.libglu1-mesa-dev
  - remnux.packages.libglib2

remnux-python3-packages-pe-tree-venv:
  virtualenv.managed:
    - name: /opt/pe-tree
    - venv_bin: /usr/bin/virtualenv
    - system_site_packages: True
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.python3-pyqt5

remnux-python3-packages-pe-tree-deps:
  pip.installed:
    - pkgs:
      - pefile
      - requests
      - cryptography
      - configparser
      - asn1crypto
      - scandir
      - filetype
      - minidump
      - capstone
    - bin_env: /opt/pe-tree/bin/python3
    - require:
      - virtualenv: remnux-python3-packages-pe-tree-venv

remnux-python3-packages-pe-tree:
  pip.installed:
    - name: pe_tree
    - bin_env: /opt/pe-tree/bin/python3
    - no_deps: True
    - upgrade: True
    - require:
      - pip: remnux-python3-packages-pe-tree-deps
      - sls: remnux.packages.libglu1-mesa-dev
      - sls: remnux.packages.libglib2

remnux-python3-packages-pe-tree-symlink:
  file.symlink:
    - name: /usr/local/bin/pe-tree
    - target: /opt/pe-tree/bin/pe-tree
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-pe-tree

{% else %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.libglu1-mesa-dev
  - remnux.packages.libglib2

remnux-python3-packages-pe-tree-venv:
  virtualenv.managed:
    - name: /opt/pe-tree
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-pe-tree:
  pip.installed:
    - name: pe_tree
    - bin_env: /opt/pe-tree/bin/python3
    - upgrade: True
    - extra_args:
      - --only-binary
      - pyqt5
    - require:
      - virtualenv: remnux-python3-packages-pe-tree-venv
      - sls: remnux.packages.libglu1-mesa-dev
      - sls: remnux.packages.libglib2

remnux-python3-packages-pe-tree-symlink:
  file.symlink:
    - name: /usr/local/bin/pe-tree
    - target: /opt/pe-tree/bin/pe-tree
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-pe-tree

{% endif %}
