# Name: dotnetfile
# Website: https://github.com/pan-unit42/dotnetfile
# Description: Analyze static properties of .NET files.
# Category: Examine Static Properties: .NET
# Author: Palo Alto Networks Unit 42
# License: MIT License: https://github.com/pan-unit42/dotnetfile/blob/main/LICENSE
# Notes: You can use the command-line tool `dotnetfile_dump.py`. Alternatively, to use this library, create a Python program that imports it and loads the .NET file, as described in https://github.com/pan-unit42/dotnetfile/blob/main/readme.md.

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-dotnetfile-venv:
  virtualenv.managed:
    - name: /opt/dotnetfile
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - dotnetfile
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-dotnetfile-dump:
  file.managed:
    - name: /opt/dotnetfile/bin/dotnetfile_dump.py
    - source: https://raw.githubusercontent.com/pan-unit42/dotnetfile/main/examples/dotnetfile_dump.py
    - source_hash: sha256=2c0cc300a51c6035a3c90c9c515ae8572207ed97be6a49d15dfc9a758df02eea
    - makedirs: false
    - mode: 755
    - require:
      - virtualenv: remnux-python3-packages-dotnetfile-venv

remnux-python3-packages-dotnetfile-dump-shebang:
  file.prepend:
    - name: /opt/dotnetfile/bin/dotnetfile_dump.py
    - text: '#!/usr/bin/env python3'
    - require:
      - file: remnux-python3-packages-dotnetfile-dump

remnux-python3-packages-dotnetfile-symlink:
  file.symlink:
    - name: /usr/local/bin/dotnetfile_dump.py
    - target: /opt/dotnetfile/bin/dotnetfile_dump.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-python3-packages-dotnetfile-dump

