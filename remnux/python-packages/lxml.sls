include:
  - remnux.packages.python-pip
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt1-dev

remnux-pip-lxml:
  pip.installed:
    - name: lxml
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.libxml2-dev
      - sls: remnux.packages.libxslt1-dev
