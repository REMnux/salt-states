# Name: virustotal-submit
# Website: https://blog.didierstevens.com/programs/virustotal-tools/
# Description: Submit files to VirusTotal.
# Category: Gather and Analyze Data
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: virustotal-submit.py

include:
  - remnux.python-packages.poster

remnux-scripts-virustotal-submit-source:
  file.managed:
    - name: /usr/local/src/remnux/files/virustotal-submit_V0_0_3.zip
    - source: http://didierstevens.com/files/software/virustotal-submit_V0_0_3.zip
    - source_hash: sha256=37CCE3E8469DE097912CB23BAC6B909C9C7F5A5CEE09C9279D32BDB9D6E23BCC
    - makedirs: True

remnux-scripts-virustotal-submit-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/virustotal-submit_V0_0_3
    - source: /usr/local/src/remnux/files/virustotal-submit_V0_0_3.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-scripts-virustotal-submit-source

remnux-scripts-virustotal-submit-binary:
  file.managed:
    - name: /usr/local/bin/virustotal-submit.py
    - source: /usr/local/src/remnux/virustotal-submit_V0_0_3/virustotal-submit.py
    - mode: 755
    - require:
      - sls: remnux.python-packages.poster
    - watch:
      - archive: remnux-scripts-virustotal-submit-archive
