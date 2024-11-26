# Name: shodan
# Website: https://github.com/achillean/shodan-python/
# Description: Query Shodan, a search engine for internet-connected devices.
# Category: Gather and Analyze Data
# Author: John Matherly
# License: Custom, free license: https://github.com/achillean/shodan-python/blob/master/LICENSE
# Notes:

{% set files = ['normalizer','shodan','tldextract','vba_extract.py'] %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-shodan-venv:
  virtualenv.managed:
    - name: /opt/shodan
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-shodan:
  pip.installed:
    - name: shodan
    - bin_env: /opt/shodan/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-shodan-venv

{% for file in files %}
remnux-python3-package-shodan-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/shodan/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-package-shodan
{% endfor %}
