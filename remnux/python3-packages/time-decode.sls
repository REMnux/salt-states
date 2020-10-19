# Name: time-decode
# Website: https://github.com/digitalsleuth/time_decode
# Description: Decode and encode date and timestamps.
# Category: Gather and Analyze Data
# Author: Corey Forman
# License: MIT License: https://github.com/digitalsleuth/time_decode/blob/master/LICENSE
# Notes: time_decode.py

include:
  - remnux.packages.python3-pip

remnux-python3-packages-time-decode:
  pip.installed:
    - name: time-decode
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
