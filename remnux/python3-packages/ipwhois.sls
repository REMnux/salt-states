# Name: ipwhois
# Website: https://github.com/secynic/ipwhois
# Description: Retrieve and parse whois data for IP addresses.
# Category: Gather and Analyze Data
# Author: Philip Hane
# License: BSD 2-Clause "Simplified" License: https://github.com/secynic/ipwhois/blob/master/LICENSE.txt
# Notes: ipwhois_cli, ipwhois_utils_cli

{% set tools = ['ipwhois_cli','ipwhois_utils_cli'] %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-ipwhois-venv:
  virtualenv.managed:
    - name: /opt/ipwhois
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-ipwhois:
  pip.installed:
    - name: ipwhois
    - bin_env: /opt/ipwhois/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-ipwhois-venv

{% for tool in tools %}
remnux-python3-packages-ipwhois-{{ tool }}-symlink:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/ipwhois/bin/{{ tool }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-ipwhois

remnux-python3-packages-ipwhois-{{ tool }}-shebang:
  file.prepend:
    - name: /opt/ipwhois/bin/{{ tool }}
    - text: '#!/opt/ipwhois/bin/python3'
    - require:
      - pip: remnux-python3-packages-ipwhois

remnux-python3-packages-ipwhois-{{ tool }}-perms:
  file.managed:
    - name: /opt/ipwhois/bin/{{ tool }}
    - mode: 755
{% endfor %}
