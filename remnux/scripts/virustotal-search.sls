# Name: virustotal-search
# Website: https://blog.didierstevens.com/programs/virustotal-tools/
# Description: Search VirusTotal for file hashes.
# Category: Gather and Analyze Data
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: virustotal-search.py

{% set version = '0_1_8' %}
{% set hash = '16fa2f9748959a88be38b4a2ff006fc658fb4ff8932f3ec2e2568f48eb9fae85' %}

remnux-scripts-virustotal-search-source:
  file.managed:
    - name: /usr/local/src/remnux/files/virustotal-search_V{{ version }}.zip
    - source: https://didierstevens.com/files/software/virustotal-search_V{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-scripts-virustotal-search-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/virustotal-search_V{{ version }}
    - source: /usr/local/src/remnux/files/virustotal-search_V{{ version }}.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-virustotal-search-source

remnux-scripts-virustotal-search-binary:
  file.managed:
    - name: /usr/local/bin/virustotal-search.py
    - source: /usr/local/src/remnux/virustotal-search_V{{ version }}/virustotal-search.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-virustotal-search-archive

remnux-scripts-virustotal-search-shebang:
  file.replace:
    - name: /usr/local/bin/virustotal-search.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python3'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-virustotal-search-binary
