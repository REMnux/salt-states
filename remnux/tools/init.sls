include:
  - remnux.tools.pdfxray_lite
  - remnux.tools.automater
  - remnux.tools.burpsuite-community
  - remnux.tools.js-patched

remnux-tools:
  test.nop:
    - require:
      - sls: remnux.tools.pdfxray_lite
      - sls: remnux.tools.automater
      - sls: remnux.tools.burpsuite-community
      - sls: remnux.tools.js-patched
