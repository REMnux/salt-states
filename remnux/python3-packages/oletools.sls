# Name: oletools
# Website: http://www.decalage.info/python/oletools
# Description: Microsoft Office OLE2 compound documents.
# Category: Analyze Documents: Microsoft Office
# Author: Philippe Lagadec: https://twitter.com/decalage2
# License: Free, custom license: https://github.com/decalage2/oletools/blob/master/LICENSE.md
# Notes: mraptor, msodde, olebrowse, oledir, oleid, olemap, olemeta, oleobj, oletimes, olevba, pyxswf, rtfobj, ezhexviewer

include:
  - remnux.packages.python3-pip
  - remnux.packages.python3-tk
  - remnux.packages.libssl-dev
  - remnux.packages.libffi-dev

oletools:
  pip.installed:
    - bin_env: /usr/bin/python3
    - install_options:
      - --prefix=/usr/local
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python3-tk
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.libffi-dev

remnux-python3-packages-olevba-shebang:
  file.replace:
    - name: /usr/local/bin/olevba
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python3-packages-olevba3-shebang:
  file.replace:
    - name: /usr/local/bin/olevba3
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python3-packages-olebrowse-shebang:
  file.replace:
    - name: /usr/local/bin/olebrowse
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python3-packages-oledir-shebang:
  file.replace:
    - name: /usr/local/bin/oledir
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python3-packages-oleid-shebang:
  file.replace:
    - name: /usr/local/bin/oleid
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python3-packages-olemap-shebang:
  file.replace:
    - name: /usr/local/bin/olemap
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python3-packages-olemeta-shebang:
  file.replace:
    - name: /usr/local/bin/olemeta
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python3-packages-oleobj-shebang:
  file.replace:
    - name: /usr/local/bin/oleobj
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python3-packages-oletimes-shebang:
  file.replace:
    - name: /usr/local/bin/oletimes
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools
