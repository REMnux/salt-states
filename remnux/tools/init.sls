include:
  - remnux.tools.pdfxray_lite
  - remnux.tools.automater
  - remnux.tools.burpsuite-community

remnux-tools:
  test.nop:
    - require:
      - sls: remnux.tools.pdfxray_lite
      - sls: remnux.tools.automater
      - sls: remnux.tools.burpsuite-community
