# Author: Didier Stevens

remnux-scripts-pdfid-source:
  file.managed:
    - name: /usr/local/src/remnux/files/pdfid_v0_2_1.zip
    - source: http://didierstevens.com/files/software/pdfid_v0_2_1.zip 
    - source_hash: sha256=f1b4728dd2ce455b863b930e12c6dec952cb95c0bb3d6924136a6e49aca877c2
    - makedirs: True

remnux-scripts-pdfid-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/pdfid-0.2.1
    - source: /usr/local/src/remnux/files/pdfid_v0_2_1.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-pdfid-source

remnux-scripts-pdfid-binary:
  file.managed:
    - name: /usr/local/bin/pdfid.py
    - source: /usr/local/src/remnux/pdfid-0.2.1/pdfid.py
    - mode: 755
    - watch:
      - archive: remnux-scripts-pdfid-archive

remnux-scripts-pdfid-plugin-embeddedfile:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_embeddedfile.py
    - source: /usr/local/src/remnux/pdfid-0.2.1/plugin_embeddedfile.py
    - user:
    - root:
    - mode: 644
    - makedirs: True

remnux-scripts-pdfid-plugin-nameobfuscation:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_nameobfuscation.py
    - source: /usr/local/src/remnux/pdfid-0.2.1/plugin_nameobfuscation.py
    - user:
    - root:
    - mode: 644
    - makedirs: True

remnux-scripts-pdfid-plugin-triage:
  file.managed:
    - name: /usr/local/share/pdfid/plugin_triage.py
    - source: /usr/local/src/remnux/pdfid-0.2.1/plugin_triage.py
    - user:
    - root:
    - mode: 644
    - makedirs: True

