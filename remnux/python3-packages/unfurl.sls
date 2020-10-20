# Name: Unfurl
# Website: https://github.com/obsidianforensics/unfurl
# Description: Deconstruct and decode data from a URL.
# Category: Explore Network Interactions: Connecting
# Author: Ryan Benson: https://twitter.com/_RyanBenson
# License: Apache License 2.0: https://github.com/obsidianforensics/unfurl/blob/master/LICENSE
# Notes: For the command-line version of the tool, run `unfurl_cli.py`. For the local browser-based version, run `unfurl_app.py`.

include:
  - remnux.python3-packages.protobuf
  - remnux.packages.python3-pip
  - remnux.packages.git

remnux-python3-packages-unfurl-requirements:
  pip.installed:
    - bin_env: /usr/bin/python3
    - requirements: https://raw.githubusercontent.com/obsidianforensics/unfurl/master/requirements.txt
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.python3-packages.protobuf

remnux-python3-packages-unfurl:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: True
    - name: git+https://github.com/obsidianforensics/unfurl.git@master
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.git
      - pip: remnux-python3-packages-unfurl-requirements
