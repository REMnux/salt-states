include:
  - remnux.scripts.pdf-parser
  - remnux.scripts.pdfid
  - remnux.python-packages.xxxswf
  - remnux.python-packages.balbuzard
  - remnux.scripts.base64dump
  - remnux.node-packages.box-js
  - remnux.scripts.brxor
  - remnux.packages.clamav-daemon
  - remnux.python-packages.flare-floss
  - remnux.packages.spidermonkey
  - remnux.scripts.oledump
  - remnux.python-packages.oletools

remnux-config-bash-completion-remnuxlib:
  file.managed:
    - name: /etc/bash_completion.d/remnuxlib
    - source: salt://remnux/config/bash-completion/remnuxlib
    - replace: False
    - makedirs: True
    - mode: 644

remnux-config-bash-completion-pdf-parser:
  file.managed:
    - name: /etc/bash_completion.d/pdf-parser
    - source: salt://remnux/config/bash-completion/pdf-parser
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.scripts.pdf-parser

remnux-config-bash-completion-pdfid:
  file.managed:
    - name: /etc/bash_completion.d/pdfid
    - source: salt://remnux/config/bash-completion/pdfid
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.scripts.pdfid

remnux-config-bash-completion-xxxswf:
  file.managed:
    - name: /etc/bash_completion.d/xxxswf
    - source: salt://remnux/config/bash-completion/xxxswf
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.python-packages.xxxswf

remnux-config-bash-completion-balbuzard:
  file.managed:
    - name: /etc/bash_completion.d/balbuzard
    - source: salt://remnux/config/bash-completion/balbuzard
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.python-packages.balbuzard

remnux-config-bash-completion-base64dump:
  file.managed:
    - name: /etc/bash_completion.d/base64dump
    - source: salt://remnux/config/bash-completion/base64dump
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.scripts.base64dump

remnux-config-bash-completion-box-js:
  file.managed:
    - name: /etc/bash_completion.d/box-js
    - source: salt://remnux/config/bash-completion/box-js
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.node-packages.box-js

remnux-config-bash-completion-brxor:
  file.managed:
    - name: /etc/bash_completion.d/brxor
    - source: salt://remnux/config/bash-completion/brxor
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.scripts.brxor

remnux-config-bash-completion-clamav:
  file.managed:
    - name: /etc/bash_completion.d/clamav
    - source: salt://remnux/config/bash-completion/clamav
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.packages.clamav-daemon

remnux-config-bash-completion-floss:
  file.managed:
    - name: /etc/bash_completion.d/floss
    - source: salt://remnux/config/bash-completion/floss
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.python-packages.flare-floss

remnux-config-bash-completion-js:
  file.managed:
    - name: /etc/bash_completion.d/js
    - source: salt://remnux/config/bash-completion/js
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.packages.spidermonkey

remnux-config-bash-completion-oledump:
  file.managed:
    - name: /etc/bash_completion.d/oledump
    - source: salt://remnux/config/bash-completion/oledump
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.scripts.oledump

remnux-config-bash-completion-olevba:
  file.managed:
    - name: /etc/bash_completion.d/olevba
    - source: salt://remnux/config/bash-completion/olevba
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.python-packages.oletools