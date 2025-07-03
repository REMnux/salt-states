# Name: PyInstaller Extractor
# Website: https://github.com/extremecoders-re/pyinstxtractor
# Description: Extract contents of a PyInstaller-generated PE files.
# Category: Statically Analyze Code: Python
# Author: extremecoders-re
# License: GNU General Public License (GPL) v3: https://github.com/extremecoders-re/pyinstxtractor/blob/master/LICENSE
# Notes: pyinstxtractor.py

{% set commit = '9f005ddf2222f2c3cd2eac1115ff5d6c4f357800' %}
{% set hash = 'e90a782c5759e81b79f874579aee09959e3d5545adea96b37ebca015d19fed58' %}

include:
  - remnux.packages.python3-virtualenv

remnux-scripts-pyinstaller-extractor-venv:
  virtualenv.managed:
    - name: /opt/pyinstaller-extractor
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-pyinstaller-extractor:
  file.managed:
    - name: /opt/pyinstaller-extractor/bin/pyinstxtractor.py
    - source: https://github.com/extremecoders-re/pyinstxtractor/raw/{{ commit }}/pyinstxtractor.py
    - source_hash: sha256={{ hash }}
    - mode: 755
    - require:
      - virtualenv: remnux-scripts-pyinstaller-extractor-venv

remnux-scripts-pyinstaller-extractor-symlink:
  file.symlink:
    - name: /usr/local/bin/pyinstxtractor.py
    - target: /opt/pyinstaller-extractor/bin/pyinstxtractor.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-pyinstaller-extractor

remnux-scripts-pyinstaller-extractor-shebang:
  file.prepend:
    - name: /opt/pyinstaller-extractor/bin/pyinstxtractor.py
    - text: '#!/opt/pyinstaller-extractor/bin/python3'
    - require:
      - file: remnux-scripts-pyinstaller-extractor-symlink
