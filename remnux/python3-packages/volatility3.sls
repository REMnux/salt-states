# Name: Volatility Framework
# Website: https://github.com/volatilityfoundation/volatility3
# Description: Memory forensics tool and framework.
# Category: Perform Memory Forensics
# Author: The Volatility Foundation
# License: Volatility Software License: https://github.com/volatilityfoundation/volatility3/blob/master/LICENSE.txt
# Notes: Invoke using: vol3, volshell3. Before using, download symbols by following the links from https://github.com/volatilityfoundation/volatility3#symbol-tables and place them in `/opt/volatility3/lib/python3.*/site-packages/volatility3/symbols`

{% set files = ['vol','volshell'] %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-volatility3-venv:
  virtualenv.managed:
    - name: /opt/volatility3
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-volatility3:
  pip.installed:
    - name: volatility3
    - bin_env: /opt/volatility3/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-volatility3-venv

remnux-python3-package-volatility3-extras:
  pip.installed:
    - pkgs:
      - yara-python
      - pycryptodome
      - pyarrow
    - bin_env: /opt/volatility3/bin/python3
    - require:
      - pip: remnux-python3-package-volatility3

{% for file in files %}
remnux-python3-package-volatility3-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}3
    - target: /opt/volatility3/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-package-volatility3
{% endfor %}
