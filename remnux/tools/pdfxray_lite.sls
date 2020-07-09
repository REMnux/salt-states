# Name: pdfxray-lite
# Website: https://github.com/9b/pdfxray_lite
# Description: Examine elements of the PDF file.
# Category: Analyze Documents: PDF
# Author: Brandon Dixon
# License: Free, unknown license
# Notes: pdfxray_lite.py

include:
  - remnux.packages.git
  - remnux.python-packages.simplejson

remnux-tools-pdfxray-lite:
  git.cloned:
    - name: https://github.com/9b/pdfxray_lite.git
    - target: /usr/local/pdfxray_lite
    - user: root
    - branch: master
    - require:
      - sls: remnux.python-packages.simplejson

remnux-tools-pdfxray-lite-shebang:
  file.replace:
    - name: /usr/local/pdfxray_lite/pdfxray_lite.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/usr/bin/env python'
    - prepend_if_not_found: True
    - count: 1
    - watch:
      - git: remnux-tools-pdfxray-lite

/usr/local/bin/pdfxray_lite.py:
  file.symlink:
  - target: /usr/local/pdfxray_lite/pdfxray_lite.py
  - watch:
      - git: remnux-tools-pdfxray-lite
