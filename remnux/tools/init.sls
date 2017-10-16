include:
  - remnux.tools.pdfxray_lite
  - remnux.tools.automater

remnux-tools:
  test.nop:
    - require:
      - sls: remnux.tools.pdfxray_lite
      - sls: remnux.tools.automater
