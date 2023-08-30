# Name: dotnetfile
# Website: https://github.com/pan-unit42/dotnetfile
# Description: Analyze static properties of .NET files.
# Category: Examine Static Properties: .NET
# Author: Palo Alto Networks Unit 42
# License: MIT License: https://github.com/pan-unit42/dotnetfile/blob/main/LICENSE
# Notes: You can use the command-line tool `dotnetfile_dump.py`. Alternatively, to use this library, create a Python program that imports it and loads the .NET file, as described in https://github.com/pan-unit42/dotnetfile/blob/main/readme.md.

include:
  - remnux.python3-packages.pip
  - remnux.packages.git

remnux-python3-packages-dotnetfile:
  pip.installed:
    - name: git+https://github.com/pan-unit42/dotnetfile
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.git

remnux-python3-packages-dotnetfile-dump:
  file.managed:
    - name: /usr/local/bin/dotnetfile_dump.py
    - source: https://raw.githubusercontent.com/pan-unit42/dotnetfile/main/examples/dotnetfile_dump.py
    - source_hash: sha256=2c0cc300a51c6035a3c90c9c515ae8572207ed97be6a49d15dfc9a758df02eea
    - makedirs: false
    - mode: 755
    - require:
      - pip: remnux-python3-packages-dotnetfile

remnux-python3-packages-dotnetfile-dump-shebang:
  file.prepend:
    - name: /usr/local/bin/dotnetfile_dump.py
    - text: '#!/usr/bin/env python3'
    - require:
      - file: remnux-python3-packages-dotnetfile-dump
