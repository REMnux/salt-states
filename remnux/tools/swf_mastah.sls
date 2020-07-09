# Name: swf_mastah.py
# Website: https://github.com/9b/pdfxray_lite
# Description: Extract Flash (SWF) files from PDF files.
# Category: Statically Analyze Code: Flash, Analyze Documents: PDF
# Author: Brandon Dixon
# License: Free, unknown license
# Notes: 

include:
  - remnux.tools.pdfxray_lite

remnux-tools-swf-mastah-shebang:
  file.replace:
    - name: /usr/local/pdfxray_lite/swf_mastah.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/usr/bin/env python'
    - prepend_if_not_found: True
    - count: 1
    - require:
      - sls: remnux.tools.pdfxray_lite

/usr/local/bin/swf_mastah.py:
  file.symlink:
  - target: /usr/local/pdfxray_lite/swf_mastah.py
  - require:
    - sls: remnux.tools.pdfxray_lite
  - watch:
    - file: remnux-tools-swf-mastah-shebang

