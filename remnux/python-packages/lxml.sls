include:
  - remnux.packages.python-pip
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt-dev

lxml:
  pip.installed:
    - require:
      - pkg: python-pip
      - pkg: libxml2-dev
      - pkg: libxslt-dev