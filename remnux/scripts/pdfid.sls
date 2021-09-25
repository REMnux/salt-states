# Name: pdfid.py
# Website: https://blog.didierstevens.com/programs/pdf-tools/
# Description: Identify suspicious elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Didier Stevens
# License: Public Domain
# Notes: 

remnux-scripts-pdfid-source:
  file.managed:
    - name: /usr/local/src/remnux/files/pdfid_v0_2_8.zip
    - source: https://didierstevens.com/files/software/pdfid_v0_2_8.zip
    - source_hash: sha256=0D0AA12592FA29BC5E7A9C3CFA0AAEBB711CEF373A0AE0AD523723C64C9D02B4
    - makedirs: True

remnux-scripts-pdfid-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/pdfid_v0_2_8
    - source: /usr/local/src/remnux/files/pdfid_v0_2_8.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-scripts-pdfid-source

remnux-scripts-pdfid-binary:
  file.managed:
    - name: /usr/local/bin/pdfid.py
    - source: /usr/local/src/remnux/pdfid_v0_2_8/pdfid.py
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
    - source: /usr/local/src/remnux/pdfid_v0_2_8/pdfid.ini
    - mode: 644
    - require:
      - file: remnux-scripts-pdfid-binary

remnux-scripts-pdfid-plugin-embeddedfile:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_embeddedfile.py
    - source: /usr/local/src/remnux/pdfid_v0_2_8/plugin_embeddedfile.py
    - user:
    - root:
    - mode: 644
    - makedirs: True
    - require:
      - file: remnux-scripts-pdfid-ini

remnux-scripts-pdfid-plugin-nameobfuscation:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_nameobfuscation.py
    - source: /usr/local/src/remnux/pdfid_v0_2_8/plugin_nameobfuscation.py
    - user:
    - root:
    - mode: 644
    - makedirs: True
    - require:
      - file: remnux-scripts-pdfid-ini

remnux-scripts-pdfid-plugin-triage:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_triage.py
    - source: /usr/local/src/remnux/pdfid_v0_2_8/plugin_triage.py
    - user:
    - root:
    - mode: 644
    - makedirs: True
    - require:
      - file: remnux-scripts-pdfid-ini