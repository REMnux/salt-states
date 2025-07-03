include:
  - remnux.python3-packages.xxxswf
  - remnux.node-packages.box-js
  - remnux.packages.clamav-daemon
  - remnux.packages.flare-floss
  - remnux.packages.spidermonkey
  - remnux.python3-packages.oletools
  - remnux.python3-packages.peframe
  - remnux.python3-packages.thug
  - remnux.packages.pev
  - remnux.rubygems.pedump
  - remnux.packages.swftools
  - remnux.packages.upx-ucl
  - remnux.python3-packages.xortool
  - remnux.tools.remnux-cli
  - remnux.python3-packages.pcodedmp
  - remnux.packages.msoffice-crypt
  - remnux.packages.binee
  - remnux.python3-packages.unfurl
  - remnux.tools.capa
  - remnux.scripts.didier-stevens-scripts

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
      - sls: remnux.scripts.didier-stevens-scripts

remnux-config-bash-completion-pdfid:
  file.managed:
    - name: /etc/bash_completion.d/pdfid
    - source: salt://remnux/config/bash-completion/pdfid
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.didier-stevens-scripts

remnux-config-bash-completion-rtfdump:
  file.managed:
    - name: /etc/bash_completion.d/rtfdump
    - source: salt://remnux/config/bash-completion/rtfdump
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.didier-stevens-scripts

remnux-config-bash-completion-xxxswf:
  file.managed:
    - name: /etc/bash_completion.d/xxxswf
    - source: salt://remnux/config/bash-completion/xxxswf
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python3-packages.xxxswf

remnux-config-bash-completion-base64dump:
  file.managed:
    - name: /etc/bash_completion.d/base64dump
    - source: salt://remnux/config/bash-completion/base64dump
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.didier-stevens-scripts

remnux-config-bash-completion-box-js:
  file.managed:
    - name: /etc/bash_completion.d/box-js
    - source: salt://remnux/config/bash-completion/box-js
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.node-packages.box-js

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
      - sls: remnux.scripts.didier-stevens-scripts

remnux-config-bash-completion-zipdump:
  file.managed:
    - name: /etc/bash_completion.d/zipdump
    - source: salt://remnux/config/bash-completion/zipdump
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.didier-stevens-scripts

remnux-config-bash-completion-pecheck:
  file.managed:
    - name: /etc/bash_completion.d/pecheck
    - source: salt://remnux/config/bash-completion/pecheck
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.didier-stevens-scripts

remnux-config-bash-completion-olevba:
  file.managed:
    - name: /etc/bash_completion.d/olevba
    - source: salt://remnux/config/bash-completion/olevba
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python3-packages.oletools

remnux-config-bash-completion-peframe:
  file.managed:
    - name: /etc/bash_completion.d/peframe
    - source: salt://remnux/config/bash-completion/peframe
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python3-packages.peframe

remnux-config-bash-completion-thug:
  file.managed:
    - name: /etc/bash_completion.d/thug
    - source: salt://remnux/config/bash-completion/thug
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python3-packages.thug

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
      - sls: remnux.python3-packages.xortool

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
      - sls: remnux.python3-packages.pcodedmp

remnux-config-bash-completion-xor-kpa:
  file.managed:
    - name: /etc/bash_completion.d/xor-kpa
    - source: salt://remnux/config/bash-completion/xor-kpa
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.didier-stevens-scripts

remnux-config-bash-completion-msoffice-crypt:
  file.managed:
    - name: /etc/bash_completion.d/msoffice-crypt
    - source: salt://remnux/config/bash-completion/msoffice-crypt
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.packages.msoffice-crypt

remnux-config-bash-completion-binee:
  file.managed:
    - name: /etc/bash_completion.d/binee
    - source: salt://remnux/config/bash-completion/binee
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.packages.binee

remnux-config-bash-completion-translate:
  file.managed:
    - name: /etc/bash_completion.d/translate
    - source: salt://remnux/config/bash-completion/translate
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.scripts.didier-stevens-scripts

remnux-config-bash-completion-unfurl:
  file.managed:
    - name: /etc/bash_completion.d/unfurl
    - source: salt://remnux/config/bash-completion/unfurl
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.python3-packages.unfurl

remnux-config-bash-completion-capa:
  file.managed:
    - name: /etc/bash_completion.d/capa
    - source: salt://remnux/config/bash-completion/capa
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
      - sls: remnux.tools.capa
