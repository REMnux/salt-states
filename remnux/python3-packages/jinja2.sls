include:
  - remnux.python3-packages.pip

jinja2==3.0.3:
  pip.installed:
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
