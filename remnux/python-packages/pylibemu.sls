include:
  - remnux.packages.python-pip
  - remnux.packages.pkg-config
  - remnux.packages.libtool
  - remnux.packages.autoconf

pylibemu:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.pkg-config
      - sls: remnux.packages.libtool
      - sls: remnux.packages.autoconf
