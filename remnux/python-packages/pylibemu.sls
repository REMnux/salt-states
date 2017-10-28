include:
  - remnux.python-packages.pip
  - remnux.packages.pkg-config
  - remnux.packages.libtool
  - remnux.packages.autoconf

pylibemu:
  pip.installed:
    - require:
      - pip: pip
      - sls: remnux.packages.pkg-config
      - sls: remnux.packages.libtool
      - sls: remnux.packages.autoconf
