# Name: thug
# Website: https://github.com/buffer/thug
# Description: Examine suspicious website using this low-interaction honeyclient.
# Category: Explore Network Interactions: Connecting
# Author: Angelo Dell'Aera
# License: GNU General Public License (GPL) v2: https://github.com/buffer/thug/blob/master/LICENSE.txt
# Notes: thug -F

include:
  - remnux.packages.git
  - remnux.python3-packages.pip
  - remnux.python3-packages.setuptools
  - remnux.packages.libemu
  - remnux.packages.libgraphviz-dev
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt1-dev
  - remnux.packages.libffi-dev
  - remnux.packages.libfuzzy-dev
  - remnux.packages.libfuzzy2
  - remnux.packages.libjpeg-dev
  - remnux.packages.tesseract-ocr
  - remnux.python3-packages.stpyv8
  - remnux.python3-packages.pytesseract

remnux-python3-packages-thug-git:
  git.latest:
    - name: https://github.com/buffer/thug
    - target: /usr/local/src/thug
    - force_reset: True
    - force_checkout: True

remnux-python3-packages-thug-packages:
  pip.installed:
    - name: thug
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
    - watch:
      - git: remnux-python3-packages-thug-git

remnux-python3-packages-thug-makedir:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - names:
      - /etc/thug
    - watch:
      - pip: remnux-python3-packages-thug-packages

emnux-python3-packages-thug-conf:
  cmd.run:
    - name: cp -R /usr/local/src/thug/conf/* /etc/thug
    - watch:
      - file: remnux-python3-packages-thug-makedir