# Name: unicode
# Website: https://github.com/garabik/unicode
# Description: Display Unicode character properties.
# Category: Examine Static Properties: Deobfuscation
# Author: Radovan Garabik
# License: GNU General Public License (GPL) v3: https://github.com/garabik/unicode/blob/master/COPYING
# Notes: 

{% set tools = ['unicode','paracode'] %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-unicode-venv:
  virtualenv.managed:
    - name: /opt/unicode
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-unicode:
  pip.installed:
    - name: unicode
    - bin_env: /opt/unicode/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-unicode-venv

{% for tool in tools %}
remnux-python3-packages-unicode-symlink-{{ tool }}:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/unicode/bin/{{ tool }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-unicode
{% endfor %}
