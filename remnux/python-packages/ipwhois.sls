# Name: ipwhois
# Website: https://github.com/secynic/ipwhois
# Description: Retrieve and parse whois data for IP addresses.
# Category: Gather and Analyze Data
# Author: Philip Hane
# License: BSD 2-Clause "Simplified" License: https://github.com/secynic/ipwhois/blob/master/LICENSE.txt
# Notes: ipwhois_cli.py, ipwhois_utils_cli.py

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

ipwhois:
  pip.installed:
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip

remnux-python-packages-ipwhois_cli-shebang:
  file.replace:
    - name: /usr/local/bin/ipwhois_cli.py
    - pattern: '#!/usr/bin/env python3'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: True
    - count: 1
    - require:
      - pip: ipwhois

remnux-python-packages-ipwhois_utils-shebang:
  file.replace:
    - name: /usr/local/bin/ipwhois_utils_cli.py
    - pattern: '#!/usr/bin/env python3'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: True
    - count: 1
    - require:
      - pip: ipwhois
    - watch:
      - file: remnux-python-packages-ipwhois_cli-shebang

/usr/local/bin/ipwhois_cli.py:
  file.managed:
    - mode: 755

/usr/local/bin/ipwhois_utils_cli.py:
  file.managed:
    - mode: 755
