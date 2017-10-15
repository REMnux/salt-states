include:
  - remnux.tools.pdfxray_lite

remnux-tools:
  test.nop:
    - require:
      - sls: remnux.tools.pdfxray_lite
