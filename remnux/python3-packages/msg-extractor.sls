# Name: msg-extractor
# Website: https://github.com/TeamMsgExtractor/msg-extractor
# Description: Extract emails and attachments from MSG files.
# Category: Analyze Documents: Email Messages
# Author: https://github.com/TeamMsgExtractor/msg-extractor#credits
# License: GNU General Public License v3.0: https://github.com/TeamMsgExtractor/msg-extractor/blob/master/LICENSE.txt
# Notes: extract_msg

include:
  - remnux.packages.tzdata
  - remnux.packages.python3-virtualenv

remnux-python3-packages-extract-msg-virtualenv:
  virtualenv.managed:
    - name: /opt/extract-msg
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib_metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-extract-msg:
  pip.installed:
    - name: extract_msg
    - bin_env: /opt/extract-msg/bin/python3
    - require:
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
