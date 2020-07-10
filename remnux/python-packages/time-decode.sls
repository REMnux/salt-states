# Name: time-decode
# Website: https://github.com/digitalsleuth/time_decode
# Description: Decode and encode date and timestamps.
# Category: Gather and Analyze Data
# Author: Corey Forman
# License: MIT License: https://github.com/digitalsleuth/time_decode/blob/master/LICENSE
# Notes: time_decode.py

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-python-packages-time-decode-install:
  pip.installed:
    - name: time-decode
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
