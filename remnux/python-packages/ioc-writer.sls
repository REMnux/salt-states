include:
  - remnux.packages.python-pip
  - remnux.python-packages.lxml

remnux-pip-ioc-writer:
  pip.installed:
    - name: ioc_writer
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.python-packages.lxml
