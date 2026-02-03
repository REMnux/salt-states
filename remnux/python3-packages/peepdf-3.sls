# Name: peepdf-3
# Website: https://github.com/digitalsleuth/peepdf-3
# Description: Examine elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Jose Miguel Esparza and Corey Forman
# License: GNU General Public License (GPL) v3: https://github.com/digitalsleuth/peepdf-3/blob/main/COPYING
# Notes: To run the tool, use the command "peepdf".

{% from 'remnux/python3-packages/stpyv8.sls' import install_stpyv8 %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.libjpeg8-dev
  - remnux.packages.zlib1g-dev
  - remnux.packages.git
  - remnux.packages.python3-dev
  - remnux.packages.build-essential
  {% if grains['oscodename'] != 'noble' %}
  - remnux.python3-packages.pip
  - remnux.packages.libemu
  {% endif %}

remnux-python3-packages-peepdf-3-venv:
  virtualenv.managed:
    - name: /opt/peepdf-3
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip<=25.2
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      {% if grains['oscodename'] != 'noble' %}
      - pylibemu
      {% endif %}
    - require:
      - sls: remnux.packages.python3-virtualenv
      {% if grains['oscodename'] != 'noble' %}
      - sls: remnux.packages.libemu
      {% endif %}
      - sls: remnux.packages.libjpeg8-dev
      - sls: remnux.packages.zlib1g-dev
      - sls: remnux.packages.git
      - sls: remnux.packages.python3-dev
      - sls: remnux.packages.build-essential

{% if grains['oscodename'] == 'focal' %}
  {{ install_stpyv8('11.7.439.19', 'bf6821faf6669e07057478edf22c0e02351e7922494dbff377f216920235d8b7', '/opt/peepdf-3/bin/python3', '3.8') }}
{% else %}
  {{ install_stpyv8('12.0.267.14', '95f6cd00bed9bdf980f6cf1beabfb5b8d6c66b094732ff3dd6241cf184a0c719', '/opt/peepdf-3/bin/python3', '3.12') }}
{% endif %}

remnux-python3-packages-peepdf-3:
  pip.installed:
    - name: peepdf-3
    - bin_env: /opt/peepdf-3/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-peepdf-3-venv

remnux-python3-packages-peepdf-3-symlink:
  file.symlink:
    - name: /usr/local/bin/peepdf
    - target: /opt/peepdf-3/bin/peepdf
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-peepdf-3
