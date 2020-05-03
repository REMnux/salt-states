include:
  - remnux.tools.pdfxray_lite
  - remnux.tools.automater
  - remnux.tools.burpsuite-community
  - remnux.tools.js-patched
  - remnux.tools.flare
  - remnux.tools.flasm
  - remnux.tools.xorsearch
  - remnux.tools.networkminer
  - remnux.tools.jad
  - remnux.tools.jd-gui

remnux-tools:
  test.nop:
    - require:
      - sls: remnux.tools.pdfxray_lite
      - sls: remnux.tools.automater
      - sls: remnux.tools.burpsuite-community
      - sls: remnux.tools.js-patched
      - sls: remnux.tools.flare
      - sls: remnux.tools.flasm
      - sls: remnux.tools.xorsearch
      - sls: remnux.tools.networkminer
      - sls: remnux.tools.jad
      - sls: remnux.tools.jd-gui