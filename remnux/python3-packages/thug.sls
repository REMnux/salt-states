# Name: thug
# Website: https://github.com/buffer/thug
# Description: Examine suspicious website using this low-interaction honeyclient.
# Category: Explore Network Interactions: Connecting
# Author: Angelo Dell'Aera
# License: GNU General Public License (GPL) v2: https://github.com/buffer/thug/blob/master/LICENSE.txt
# Notes: thug -F

{% from 'remnux/python3-packages/stpyv8.sls' import install_stpyv8 %}

include:
  - remnux.packages.git
  - remnux.packages.libemu
  - remnux.packages.libgraphviz-dev
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt1-dev
  - remnux.packages.libffi-dev
  - remnux.packages.libfuzzy-dev
  - remnux.packages.libfuzzy2
  - remnux.packages.libjpeg-dev
  - remnux.packages.tesseract-ocr
  - remnux.packages.libssl-dev
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3
  - remnux.packages.python3-dev
  - remnux.packages.build-essential
  - remnux.packages.libmagic-dev

remnux-python3-packages-thug-virtualenv:
  virtualenv.managed:
    - name: /opt/thug
    - venv_bin: /usr/bin/virtualenv
    - python: /usr/bin/python3
    - pip_pkgs:
      - pip>=24.1.2
      - setuptools>=70.0.0,<82
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - yara-python
      - pytesseract
      - pycparser
      - six
      - cffi
    - require:
      - sls: remnux.packages.python3
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.python3-dev
      - sls: remnux.packages.libffi-dev

{{ install_stpyv8('12.0.267.14', '95f6cd00bed9bdf980f6cf1beabfb5b8d6c66b094732ff3dd6241cf184a0c719', '/opt/thug/bin/python3', '3.12') }}

remnux-python3-packages-thug-ssdeep:
  pip.installed:
    - name: ssdeep==3.4
    - bin_env: /opt/thug/bin/python3
    - extra_args:
      - --no-build-isolation
    - require:
      - virtualenv: remnux-python3-packages-thug-virtualenv
      - sls: remnux.packages.libfuzzy-dev
      - sls: remnux.packages.build-essential

remnux-python3-packages-thug-git:
  git.latest:
    - name: https://github.com/buffer/thug
    - target: /usr/local/src/thug
    - branch: master
    - force_reset: True
    - force_checkout: True
    - force_fetch: True
    - require:
      - sls: remnux.packages.git

remnux-python3-packages-thug-packages:
  pip.installed:
    - name: thug
    - bin_env: /opt/thug/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-thug-virtualenv
      - pip: remnux-python3-packages-thug-ssdeep
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.libmagic-dev
    - watch:
      - git: remnux-python3-packages-thug-git

remnux-python3-packages-thug-makedir:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - names:
      - /etc/thug
    - watch:
      - pip: remnux-python3-packages-thug-packages

remnux-python3-packages-thug-conf:
  cmd.run:
    - name: cp -R /usr/local/src/thug/thug/conf/* /etc/thug
    - watch:
      - file: remnux-python3-packages-thug-makedir

remnux-python3-packages-thug-symlink:
  file.symlink:
    - name: /usr/local/bin/thug
    - target: /opt/thug/bin/thug
    - makedirs: False
    - force: True
    - require:
      - pip: remnux-python3-packages-thug-packages
