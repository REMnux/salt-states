# Name: ipwhois
# Website: https://github.com/secynic/ipwhois
# Description: Retrieve and parse whois data for IP addresses.
# Category: Gather and Analyze Data
# Author: Philip Hane
# License: BSD 2-Clause "Simplified" License: https://github.com/secynic/ipwhois/blob/master/LICENSE.txt
# Notes: ipwhois_cli.py, ipwhois_utils_cli.py

include:
  - remnux.python3-packages.pip

remnux-python3-packages-ipwhois:
  pip.installed:
    - name: ipwhois
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip

remnux-python3-packages-ipwhois_cli-shebang:
  file.prepend:
    - name: /usr/local/bin/ipwhois_cli.py
    - text: '#!/usr/bin/env python3'
    - require:
      - pip: remnux-python3-packages-ipwhois

remnux-python3-packages-ipwhois_utils-shebang:
  file.prepend:
    - name: /usr/local/bin/ipwhois_utils_cli.py
    - text: '#!/usr/bin/env python3'
    - require:
      - pip: remnux-python3-packages-ipwhois
    - watch:
      - file: remnux-python3-packages-ipwhois_cli-shebang

/usr/local/bin/ipwhois_cli.py:
  file.managed:
    - mode: 755

/usr/local/bin/ipwhois_utils_cli.py:
  file.managed:
    - mode: 755
