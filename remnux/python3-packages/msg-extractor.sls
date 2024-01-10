# Name: msg-extractor
# Website: https://github.com/TeamMsgExtractor/msg-extractor
# Description: Extract emails and attachments from MSG files.
# Category: Analyze Documents: Email messages
# Author: https://github.com/TeamMsgExtractor/msg-extractor#credits
# License: GNU General Public License v3.0: https://github.com/TeamMsgExtractor/msg-extractor/blob/master/LICENSE.txt
# Notes: extract_msg

include:
  - remnux.python3-packages.pip
  - remnux.packages.tzdata
  - remnux.packages.virtualenv

remnux-python3-packages-remove-extract-msg:
  pip.removed:
    - name: extract_msg
    - bin_env: /usr/bin/python3

remnux-python3-packages-extract-msg-virtualenv:
  virtualenv.managed:
    - name: /opt/extract-msg
    - venv_bin: /usr/bin/virtualenv
    - python: /usr/bin/python3
    - pip_pkgs:
      - pip>=23.1.2
      - setuptools==67.7.2
      - wheel==0.38.4
    - require:
      - sls: remnux.packages.virtualenv
      - sls: remnux.python3-packages.pip
      - pip: remnux-python3-packages-remove-extract-msg

remnux-python3-packages-extract-msg:
  pip.installed:
    - name: extract_msg
    - bin_env: /opt/extract-msg/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.tzdata
      - virtualenv: remnux-python3-packages-extract-msg-virtualenv

remnux-python3-packages-extract-msg-symlink:
  file.symlink:
    - name: /usr/local/bin/extract_msg
    - target: /opt/extract-msg/bin/extract_msg
    - makedirs: False
    - force: True
    - require:
      - pip: remnux-python3-packages-extract-msg
