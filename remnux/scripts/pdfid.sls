# Name: pdfid.py
# Website: https://blog.didierstevens.com/programs/pdf-tools/
# Description: Identify suspicious elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Didier Stevens
# License: Public Domain
# Notes: 

remnux-scripts-pdfid-source:
  file.managed:
    - name: /usr/local/src/remnux/files/pdfid_v0_2_7.zip
    - source: https://didierstevens.com/files/software/pdfid_v0_2_7.zip
    - source_hash: sha256=FE2B59FE458ECBC1F91A40095FB1536E036BDD4B7B480907AC4E387D9ADB6E60
    - makedirs: True

remnux-scripts-pdfid-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/pdfid_v0_2_7
    - source: /usr/local/src/remnux/files/pdfid_v0_2_7.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-scripts-pdfid-source

remnux-scripts-pdfid-binary:
  file.managed:
    - name: /usr/local/bin/pdfid.py
    - source: /usr/local/src/remnux/pdfid_v0_2_7/pdfid.py
    - mode: 755
    - require:
      - archive: remnux-scripts-pdfid-archive

remnux-scripts-pdfid-shebang:
  file.replace:
    - name: /usr/local/bin/pdfid.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python3\n'
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-pdfid-binary

remnux-scripts-pdfid-ini:
  file.managed:
    - name: /usr/local/bin/pdfid.ini
    - source: /usr/local/src/remnux/pdfid_v0_2_7/pdfid.ini
    - mode: 755
    - require:
      - file: remnux-scripts-pdfid-binary

remnux-scripts-pdfid-plugin-embeddedfile:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_embeddedfile.py
    - source: /usr/local/src/remnux/pdfid_v0_2_7/plugin_embeddedfile.py
    - user:
    - root:
    - mode: 644
    - makedirs: True
    - require:
      - file: remnux-scripts-pdfid-ini

remnux-scripts-pdfid-plugin-nameobfuscation:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_nameobfuscation.py
    - source: /usr/local/src/remnux/pdfid_v0_2_7/plugin_nameobfuscation.py
    - user:
    - root:
    - mode: 644
    - makedirs: True
    - require:
      - file: remnux-scripts-pdfid-ini

remnux-scripts-pdfid-plugin-triage:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_triage.py
    - source: /usr/local/src/remnux/pdfid_v0_2_7/plugin_triage.py
    - user:
    - root:
    - mode: 644
    - makedirs: True
    - require:
      - file: remnux-scripts-pdfid-ini