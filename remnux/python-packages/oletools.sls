# Name: oletools
# Website: http://www.decalage.info/python/oletools
# Description: Microsoft Office OLE2 compound documents.
# Category: Analyze Documents: Microsoft Office
# Author: Philippe Lagadec: https://twitter.com/decalage2
# License: Free, custom license: https://github.com/decalage2/oletools/blob/master/LICENSE.md
# Notes: mraptor, msodde, olebrowse, oledir, oleid, olemap, olemeta, oleobj, oletimes, olevba, pyxswf, rtfobj

include:
  - remnux.packages.python3-pip
  - remnux.packages.python3-tk
  - remnux.packages.python-pip

oletools:
  pip.installed:
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python3-tk

remnux-python-packages-olevba-shebang:
  file.replace:
    - name: /usr/local/bin/olevba
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python-packages-olevba3-shebang:
  file.replace:
    - name: /usr/local/bin/olevba3
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python-packages-olebrowse-shebang:
  file.replace:
    - name: /usr/local/bin/olebrowse
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python-packages-oledir-shebang:
  file.replace:
    - name: /usr/local/bin/oledir
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python-packages-oleid-shebang:
  file.replace:
    - name: /usr/local/bin/oleid
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python-packages-olemap-shebang:
  file.replace:
    - name: /usr/local/bin/olemap
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python-packages-olemeta-shebang:
  file.replace:
    - name: /usr/local/bin/olemeta
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python-packages-oleobj-shebang:
  file.replace:
    - name: /usr/local/bin/oleobj
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools

remnux-python-packages-oletimes-shebang:
  file.replace:
    - name: /usr/local/bin/oletimes
    - pattern: '#!/usr/bin/python2'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: oletools