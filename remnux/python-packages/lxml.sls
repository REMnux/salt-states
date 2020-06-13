include:
  - remnux.packages.python-pip
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt1-dev

lxml:
  pip.installed:
    - require:
      - pkg: python-pip
      - pkg: libxml2-dev
      - pkg: libxslt1-dev