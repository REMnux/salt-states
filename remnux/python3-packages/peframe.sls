# Name: PEframe
# Website: https://github.com/digitalsleuth/peframe
# Description: Statically analyze PE and Microsoft Office files.
# Category: Examine Static Properties: PE Files
# Author: Gianni Amato: https://x.com/guelfoweb
# License: Free, unknown license
# Notes: peframe

{% from "remnux/osarch.sls" import osarch with context %}
include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.build-essential
  - remnux.packages.libncurses
  - remnux.packages.libmagic-dev
  - remnux.packages.python3-dev

remnux-python3-packages-peframe-venv:
  virtualenv.managed:
    - name: /opt/peframe
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

{% if osarch == "arm64" %}
{# peframe-ds depends on the PyPI readline package, which bundles readline 6.2, whose build
   cannot detect arm64. Python's own readline module already covers Linux, so arm64 installs
   peframe-ds's other dependencies, then peframe-ds without dependencies. #}
remnux-python3-packages-peframe-deps:
  pip.installed:
    - pkgs:
      - pefile
      - requests
      - python-magic
      - yara-python
      - oletools
      - cryptography
    - bin_env: /opt/peframe/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-peframe-venv
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.libncurses
      - sls: remnux.packages.libmagic-dev
      - sls: remnux.packages.python3-dev

{% endif %}
remnux-python3-packages-peframe:
  pip.installed:
    - name: peframe-ds
    - bin_env: /opt/peframe/bin/python3
    - upgrade: True
{% if osarch == "arm64" %}
    - no_deps: True
{% endif %}
    - require:
      - virtualenv: remnux-python3-packages-peframe-venv
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.libncurses
      - sls: remnux.packages.libmagic-dev
      - sls: remnux.packages.python3-dev
{% if osarch == "arm64" %}
      - pip: remnux-python3-packages-peframe-deps
{% endif %}

remnux-python3-packages-peframe-symlink:
  file.symlink:
    - name: /usr/local/bin/peframe
    - target: /opt/peframe/bin/peframe
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-peframe
