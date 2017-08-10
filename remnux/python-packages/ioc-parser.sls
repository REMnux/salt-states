include:
  - remnux.packages.python-pip

remnux-pip-ioc-parser:
  pip.installed:
    - name: ioc_parser
    - require:
      - sls: remnux.packages.python-pip
