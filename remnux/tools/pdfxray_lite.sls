# Source: https://github.com/9b/pdfxray_lite
# Author: Brandon Dixon

include:
  - remnux.packages.git
  - remnux.python-packages.simplejson

remnux-tools-pdfxray-lite:
  git.latest:
    - name: https://github.com/9b/pdfxray_lite.git
    - target: /usr/local/pdfxray_lite
    - user: root
    - branch: master
    - force_fetch: True
    - force_checkout: True
    - force_clone: True
    - force_reset: True
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

emnux-tools-swf-mastah-shebang:
  file.replace:
    - name: /usr/local/pdfxray_lite/swf_mastah.py
    - pattern: '#!/usr/bin/env python'
    - repl: '#!/usr/bin/env python'
    - prepend_if_not_found: True
    - count: 1
    - watch:
      - git: remnux-tools-pdfxray-lite

/usr/local/bin/swf_mastah.py:
  file.symlink:
  - target: /usr/local/pdfxray_lite/swf_mastah.py
  - watch:
    - git: remnux-tools-pdfxray-lite
