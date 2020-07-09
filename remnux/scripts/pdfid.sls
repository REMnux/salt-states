# Name: pdfid
# Website: https://blog.didierstevens.com/programs/pdf-tools/
# Description: Identify suspicious elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Didier Stevens
# License: Public Domain
# Notes: 

remnux-scripts-pdfid-source:
  file.managed:
    - name: /usr/local/src/remnux/files/pdfid_v0_2_5.zip
    - source: https://didierstevens.com/files/software/pdfid_v0_2_5.zip
    - source_hash: sha256=4DD43D7BDA885C5A579FC1F797E93A536E1DB5A4AB52A9337759A69D3B0250E0
    - makedirs: True

remnux-scripts-pdfid-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/pdfid-0.2.5
    - source: /usr/local/src/remnux/files/pdfid_v0_2_5.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-pdfid-source

remnux-scripts-pdfid-binary:
  file.managed:
    - name: /usr/local/bin/pdfid.py
    - source: /usr/local/src/remnux/pdfid-0.2.5/pdfid.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-pdfid-archive

remnux-scripts-pdfid-plugin-embeddedfile:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_embeddedfile.py
    - source: /usr/local/src/remnux/pdfid-0.2.5/plugin_embeddedfile.py
    - user:
    - root:
    - mode: 644
    - makedirs: True

remnux-scripts-pdfid-plugin-nameobfuscation:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_nameobfuscation.py
    - source: /usr/local/src/remnux/pdfid-0.2.5/plugin_nameobfuscation.py
    - user:
    - root:
    - mode: 644
    - makedirs: True

remnux-scripts-pdfid-plugin-triage:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_triage.py
    - source: /usr/local/src/remnux/pdfid-0.2.5/plugin_triage.py
    - user:
    - root:
    - mode: 644
    - makedirs: True
