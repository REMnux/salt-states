# Name: debloat
# Website: https://github.com/Squiblydoo/debloat
# Description: Remove junk contents from bloated Windows executables.
# Category: Examine Static Properties: PE Files
# Author: Squiblydoo: https://x.com/SquiblydooBlog
# License: BSD 3-Clause License: https://github.com/Squiblydoo/debloat/blob/main/LICENSE
# Notes: Run the command-line version as `debloat` or the GUI version as `debloat-gui`

{% set files = ['debloat','debloat-gui'] %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-tk

remnux-python3-packages-debloat-venv:
  virtualenv.managed:
    - name: /opt/debloat
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-debloat:
  pip.installed:
    - name: debloat
    - bin_env: /opt/debloat/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-debloat-venv
      - sls: remnux.packages.python3-tk

{% for file in files %}
remnux-python3-packages-debloat-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/debloat/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-debloat
{% endfor %}
