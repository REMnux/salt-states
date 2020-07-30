include:
  - remnux.packages.python-pip
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt1-dev
  - remnux.packages.python3-pip

lxml:
  pip.installed:
    - bin_env: /usr/bin/python
    - require:
      - pkg: python-pip
      - pkg: libxml2-dev
      - pkg: libxslt1-dev