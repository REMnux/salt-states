include:
  - remnux.packages.python3-pip

remnux-pip-ioc-parser:
  pip.installed:
    - name: ioc_parser
    - bin_env: '/usr/bin/pip3'
    - require:
      - sls: remnux.packages.python3-pip
