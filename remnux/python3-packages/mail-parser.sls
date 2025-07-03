# Name: mail-parser
# Website: https://github.com/SpamScope/mail-parser
# Description: Parse raw SMTP and .MSG email messages and generate a parsed object from them.
# Category: Analyze Documents: Email Messages
# Author: Fedele Mantuano: https://twitter.com/fedelemantuano
# License: Apache License 2.0: https://github.com/SpamScope/mail-parser/blob/develop/LICENSE.txt
# Notes: Run the tool using command `mailparser`

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.libemail-outlook-message-perl

remnux-python3-packages-mail-parser-venv:
  virtualenv.managed:
    - name: /opt/mail-parser
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-mail-parser:
  pip.installed:
    - name: mail-parser
    - bin_env: /opt/mail-parser/bin/python3
    - upgrade: True
    - ignore_installed: True
    - require:
      - virtualenv: remnux-python3-packages-mail-parser-venv
      - sls: remnux.packages.libemail-outlook-message-perl

remnux-python3-packages-mail-parser-symlink:
  file.symlink:
    - name: /usr/local/bin/mail-parser
    - target: /opt/mail-parser/bin/mail-parser
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-mail-parser
