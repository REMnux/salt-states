include:
  - remnux.packages.python2-pip
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt1-dev
  - remnux.packages.python3-pip

lxml:
  pip.installed:
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.libxml2-dev
      - sls: remnux.packages.libxslt1-dev
