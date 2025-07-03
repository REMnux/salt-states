# Name: fakemail
# Website: https://hg.sr.ht/~olly/fakemail
# Description: Intercept and examine SMTP email activity with this fake SMTP server.
# Category: Explore Network Interactions: Services
# Author: Oliver Cope
# License: Apache License 2.0: https://hg.sr.ht/~olly/fakemail/browse/LICENSE.txt?rev=default
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-fakemail-venv:
  virtualenv.managed:
    - name: /opt/fakemail
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-fakemail:
  pip.installed:
    - name: fakemail
    - bin_env: /opt/fakemail/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-fakemail-venv

remnux-python3-packages-fakemail-symlink:
  file.symlink:
    - name: /usr/local/bin/fakemail
    - target: /opt/fakemail/bin/fakemail
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-fakemail
