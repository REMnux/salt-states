include:
  - remnux.tools.pdfxray_lite
  - remnux.tools.automater
  - remnux.tools.burpsuite-community
  - remnux.tools.js-patched
  - remnux.tools.flare
  - remnux.tools.flasm

remnux-tools:
  test.nop:
    - require:
      - sls: remnux.tools.pdfxray_lite
      - sls: remnux.tools.automater
      - sls: remnux.tools.burpsuite-community
      - sls: remnux.tools.js-patched
      - sls: remnux.tools.flare
      - sls: remnux.tools.flasm
