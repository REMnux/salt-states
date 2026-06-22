# Name: GootLoaderAutoJsDecode.py
# Command: gootloader-decode
# Website: https://github.com/mandiant/gootloader
# Description: Statically deobfuscate GootLoader (GOOTLOADER) malicious JScript to recover the payload and extract C2 domains.
# Category: Statically Analyze Code: Scripts
# Author: Mandiant: https://github.com/mandiant
# License: Apache License 2.0: https://github.com/mandiant/gootloader/blob/main/LICENSE.txt
# Notes: gootloader-decode. Run `gootloader-decode malicious.js`; it writes DecodedJsPayload.js_ and FileAndTaskData.txt to the working directory and prints extracted domains. Only the safe static decoder is packaged; the repo's dynamic and manual scripts execute malware code and are intentionally excluded.

{% set commit = 'fd302e8b9ff23e34510c42a52e377712587e7094' %}
{% set hash = 'a7662ef153e506ab4bbfbf0be84e2bd3e55892a76793c313bb8c8942bb794793' %}

include:
  - remnux.packages.python3-virtualenv

remnux-scripts-gootloader-venv:
  virtualenv.managed:
    - name: /opt/gootloader
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-scripts-gootloader:
  file.managed:
    - name: /opt/gootloader/bin/GootLoaderAutoJsDecode.py
    - source: https://github.com/mandiant/gootloader/raw/{{ commit }}/GootLoaderAutoJsDecode.py
    - source_hash: sha256={{ hash }}
    - mode: 755
    - makedirs: false
    - require:
      - virtualenv: remnux-scripts-gootloader-venv

remnux-scripts-gootloader-symlink:
  file.symlink:
    - name: /usr/local/bin/gootloader-decode
    - target: /opt/gootloader/bin/GootLoaderAutoJsDecode.py
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-gootloader

remnux-scripts-gootloader-shebang:
  file.replace:
    - name: /opt/gootloader/bin/GootLoaderAutoJsDecode.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/opt/gootloader/bin/python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-gootloader-symlink
