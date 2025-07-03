# Name: XLMMacroDeobfuscator
# Website: https://github.com/DissectMalware/XLMMacroDeobfuscator
# Description: Deobfuscate XLM macros (also known as Excel 4.0 macros) from Microsoft Office files.
# Category: Analyze Documents: Microsoft Office
# Author: https://twitter.com/DissectMalware
# License: Apache License 2.0: https://github.com/DissectMalware/XLMMacroDeobfuscator/blob/master/LICENSE
# Notes: xlmdeobfuscator, runxlrd2.py
{% set tools = ['xlmdeobfuscator','runxlrd2.py'] %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-xlmmacrodeobfuscator-venv:
  virtualenv.managed:
    - name: /opt/xlmmacrodeobfuscator
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-xlmmacrodeobfuscator:
  pip.installed:
    - name: xlmmacrodeobfuscator
    - bin_env: /opt/xlmmacrodeobfuscator/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-xlmmacrodeobfuscator-venv

{% for tool in tools %}
remnux-python3-packages-xlmmacrodeobfuscator-symlink-{{ tool }}:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/xlmmacrodeobfuscator/bin/{{ tool }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-xlmmacrodeobfuscator
{% endfor %}
/opt/xlmmacrodeobfuscator/bin/runxlrd2.py:
  file.managed:
    - replace: False
    - mode: 755
    - require:
      - pip: remnux-python3-packages-xlmmacrodeobfuscator

remnux-python3-packages-xlmmacrodeobfuscator-runxlrd2-replace:
  file.replace:
    - name: /opt/xlmmacrodeobfuscator/bin/runxlrd2.py
    - pattern: '^#!/usr/bin/env python.*$'
    - repl: '#!/opt/xlmmacrodeobfuscator/bin/python3'
    - prepend_if_not_found: False
    - count: 1
    - backup: False
    - require:
      - pip: remnux-python3-packages-xlmmacrodeobfuscator
