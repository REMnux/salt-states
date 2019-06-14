include:
  - remnux.scripts.pdf-parser
  - remnux.scripts.pdfobjflow
  - remnux.scripts.pdfid
  - remnux.scripts.oledump
  - remnux.scripts.emldump
  - remnux.scripts.officeparser
  - remnux.scripts.extractscripts
  - remnux.scripts.virustotal-search
  - remnux.scripts.base64dump

remnux-scripts:
  test.nop:
    - require:
      - sls: remnux.scripts.pdf-parser
      - sls: remnux.scripts.pdfobjflow
      - sls: remnux.scripts.pdfid
      - sls: remnux.scripts.oledump
      - sls: remnux.scripts.emldump
      - sls: remnux.scripts.officeparser
      - sls: remnux.scripts.extractscripts
      - sls: remnux.scripts.virustotal-search
      - sls: remnux.scripts.base64dump
