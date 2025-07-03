# Name: JS Beautifier
# Website: https://beautifier.io/
# Description: Reformat JavaScript scripts for easier analysis.
# Category: Statically Analyze Code: Scripts
# Author: Einar Lielmanis, Liam Newman, and contributors
# License: MIT License: https://github.com/beautify-web/js-beautify/blob/master/LICENSE
# Notes: js-beautify

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-jsbeautifier-venv:
  virtualenv.managed:
    - name: /opt/jsbeautifier
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-jsbeautifier:
  pip.installed:
    - name: jsbeautifier
    - bin_env: /opt/jsbeautifier/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-jsbeautifier-venv

remnux-python3-packages-jsbeautifier-symlink:
  file.symlink:
    - name: /usr/local/bin/js-beautify
    - target: /opt/jsbeautifier/bin/js-beautify
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-jsbeautifier

remnux-python3-packages-jsbeautifier-editorconfig-symlink:
  file.symlink:
    - name: /usr/local/bin/editorconfig
    - target: /opt/jsbeautifier/bin/editorconfig
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-jsbeautifier
