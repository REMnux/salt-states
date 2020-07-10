include:
  - remnux.scripts.pdf-parser
  - remnux.scripts.pdfid
  - remnux.scripts.rtfdump
  - remnux.python-packages.xxxswf
  - remnux.python-packages.balbuzard
  - remnux.scripts.base64dump
  - remnux.node-packages.box-js
  - remnux.scripts.brxor
  - remnux.packages.clamav-daemon
  - remnux.packages.flare-floss
  - remnux.packages.spidermonkey
  - remnux.scripts.oledump
  - remnux.python-packages.oletools
  - remnux.python-packages.peframe
  - remnux.scripts.shellcode2exe-py
  - remnux.python-packages.thug
  - remnux.python-packages.volatility
  - remnux.packages.pev
  - remnux.rubygems.pedump
  - remnux.packages.swftools
  - remnux.packages.upx-ucl
  - remnux.python-packages.xortool
  - remnux.scripts.virustotal-search
  - remnux.tools.remnux-cli
  - remnux.python-packages.pcodedmp
  - remnux.scripts.xor-kpa
  - remnux.packages.msoffice-crypt

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

remnux-config-bash-completion-rtfdump:
  file.managed:
    - name: /etc/bash_completion.d/rtfdump
    - source: salt://remnux/config/bash-completion/rtfdump
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.rtfdump

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
      - sls: remnux.packages.flare-floss

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

remnux-config-bash-completion-peframe:
  file.managed:
    - name: /etc/bash_completion.d/peframe
    - source: salt://remnux/config/bash-completion/peframe
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python-packages.peframe

remnux-config-bash-completion-shellcode2exe-py:
  file.managed:
    - name: /etc/bash_completion.d/shellcode2exe-py
    - source: salt://remnux/config/bash-completion/shellcode2exe-py
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.shellcode2exe-py

remnux-config-bash-completion-thug:
  file.managed:
    - name: /etc/bash_completion.d/thug
    - source: salt://remnux/config/bash-completion/thug
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python-packages.thug

remnux-config-bash-completion-volatility:
  file.managed:
    - name: /etc/bash_completion.d/volatility
    - source: salt://remnux/config/bash-completion/volatility
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python-packages.volatility

remnux-config-bash-completion-pev:
  file.managed:
    - name: /etc/bash_completion.d/pev
    - source: salt://remnux/config/bash-completion/pev
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.packages.pev

remnux-config-bash-completion-pedump:
  file.managed:
    - name: /etc/bash_completion.d/pedump
    - source: salt://remnux/config/bash-completion/pedump
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.rubygems.pedump

remnux-config-bash-completion-swfdump:
  file.managed:
    - name: /etc/bash_completion.d/swfdump
    - source: salt://remnux/config/bash-completion/swfdump
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.packages.swftools

remnux-config-bash-completion-upx:
  file.managed:
    - name: /etc/bash_completion.d/upx
    - source: salt://remnux/config/bash-completion/upx
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.packages.upx-ucl

remnux-config-bash-completion-xortool:
  file.managed:
    - name: /etc/bash_completion.d/xortool
    - source: salt://remnux/config/bash-completion/xortool
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python-packages.xortool

remnux-config-bash-completion-virustotal-search:
  file.managed:
    - name: /etc/bash_completion.d/virustotal-search
    - source: salt://remnux/config/bash-completion/virustotal-search
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.virustotal-search

remnux-config-bash-completion-remnux-cli:
  file.managed:
    - name: /etc/bash_completion.d/remnix-cli
    - source: salt://remnux/config/bash-completion/remnux-cli
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.tools.remnux-cli

remnux-config-bash-completion-pcodedmp:
  file.managed:
    - name: /etc/bash_completion.d/pcodedmp
    - source: salt://remnux/config/bash-completion/pcodedmp
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python-packages.pcodedmp

remnux-config-bash-completion-xor-kpa:
  file.managed:
    - name: /etc/bash_completion.d/xor-kpa
    - source: salt://remnux/config/bash-completion/xor-kpa
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.xor-kpa

remnux-config-bash-completion-msoffice-crypt:
  file.managed:
    - name: /etc/bash_completion.d/msoffice-crypt
    - source: salt://remnux/config/bash-completion/msoffice-crypt
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.packages.msoffice-crypt