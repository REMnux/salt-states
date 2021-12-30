# Name: cs-decrypt-metadata.py
# Website: https://blog.didierstevens.com/2021/11/12/update-cs-decrypt-metadata-py-version-0-0-2/
# Description: Decrypt Cobalt Strike metadata.
# Category: Examine Static Properties: Deobfuscation
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: 

{%- set archivename="cs-decrypt-metadata_V0_0_4.zip" %}
{%- set dirname="cs-decrypt-metadata_V0_0_4" %}
{%- set url="https://didierstevens.com/files/software/cs-decrypt-metadata_V0_0_4.zip" %}
{%- set hash="CAFCCE9A8897C257AE39259D3F444E0F40473BF0D9590DC1A035316EBDDBBC84" %}

include:
  - remnux.python3-packages.pycryptodome

remnux-scripts-cs-decrypt-metadata-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ archivename }}
    - source: {{ url }}
    - source_hash: {{ hash }}
    - makedirs: True
    - require:
      - sls: remnux.python3-packages.pycryptodome

remnux-scripts-cs-decrypt-metadata-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/{{ dirname }}
    - source: /usr/local/src/remnux/files/{{ archivename }}
    - enforce_toplevel: False
    - require:
      - file: remnux-scripts-cs-decrypt-metadata-source

remnux-scripts-cs-decrypt-metadata-binary:
  file.managed:
    - name: /usr/local/bin/cs-decrypt-metadata.py
    - source: /usr/local/src/remnux/{{ dirname }}/cs-decrypt-metadata.py
    - mode: 755
    - require:
      - archive: remnux-scripts-cs-decrypt-metadata-archive

remnux-scripts-cs-decrypt-metadata-shebang:
  file.replace:
    - name: /usr/local/bin/cs-decrypt-metadata.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-cs-decrypt-metadata-binary