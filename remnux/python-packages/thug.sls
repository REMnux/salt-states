# Name: thug
# Website: https://github.com/buffer/thug
# Description: Examine suspicious website using this low-interaction honeyclient.
# Category: Explore Network Interactions: Connecting
# Author: Angelo Dell'Aera
# License: GNU General Public License (GPL) v2: https://github.com/buffer/thug/blob/master/LICENSE.txt
# Notes: thug -F

include:
  - remnux.packages.git
  - remnux.packages.python3
  - remnux.packages.python3-setuptools
  - remnux.packages.python3-pip
  - remnux.packages.libemu
  - remnux.packages.libgraphviz-dev
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt1-dev
  - remnux.packages.libffi-dev
  - remnux.packages.libfuzzy-dev
  - remnux.packages.libfuzzy2
  - remnux.packages.libjpeg-dev
  - remnux.packages.tesseract-ocr
  - remnux.python-packages.stpyv8
  - remnux.python-packages.pytesseract
  - remnux.packages.python-pip

remnux-git-thug:
  git.cloned:
    - name: https://github.com/buffer/thug
    - target: /usr/local/src/thug

remnux-pip3-install-thug:
  pip.installed:
    - name: thug
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python-pip
    - watch:
      - git: remnux-git-thug

remnux-makedirs-thug:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - names:
      - /etc/thug
      - /etc/thug/rules
      - /etc/thug/personalities
      - /etc/thug/scripts
      - /etc/thug/plugins
      - /etc/thug/hooks
    - watch:
      - pip: remnux-pip3-install-thug

remnux-copy-rules-thug:
  cmd.run:
    - name: cp -R /usr/local/src/thug/thug/Classifier/rules/* /etc/thug/rules
    - watch:
      - file: remnux-makedirs-thug

remnux-copy-personalities-thug:
  cmd.run:
    - name: cp -R /usr/local/src/thug/thug/DOM/personalities/* /etc/thug/personalities
    - watch:
      - cmd: remnux-copy-rules-thug

remnux-copy-files-thug:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - names:
      - /etc/thug/scripts/thug.js:
        - source: /usr/local/src/thug/thug/DOM/thug.js
      - /etc/thug/scripts/storage.js:
        - source: /usr/local/src/thug/thug/DOM/storage.js
      - /etc/thug/scripts/date.js:
        - source: /usr/local/src/thug/thug/DOM/date.js
      - /etc/thug/scripts/eval.js:
        - source: /usr/local/src/thug/thug/DOM/eval.js
      - /etc/thug/scripts/write.js:
        - source: /usr/local/src/thug/thug/DOM/write.js
      - /etc/thug/thug.conf:
        - source: /usr/local/src/thug/conf/thug.conf
    - watch:
      - cmd: remnux-copy-personalities-thug
