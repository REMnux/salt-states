# Name: mail-parser
# Website: https://github.com/SpamScope/mail-parser
# Description: Parse raw SMTP and .MSG email messages and generate a parsed object from them.
# Category: Analyze Documents: Email Messages
# Author: Fedele Mantuano: https://twitter.com/fedelemantuano
# License: Apache License 2.0: https://github.com/SpamScope/mail-parser/blob/develop/LICENSE.txt
# Notes: Run the tool using command `mailparser`

include:
  - remnux.python3-packages.pip
  - remnux.packages.libemail-outlook-message-perl

remnux-python3-packages-mail-parser:
  pip.installed:
    - name: mail-parser
    - bin_env: /usr/bin/python3
    - upgrade: True
    - ignore_installed: True
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.libemail-outlook-message-perl
