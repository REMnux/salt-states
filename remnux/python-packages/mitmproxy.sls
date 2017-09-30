include:
  - remnux.packages.libffi-dev
  - remnux.packages.libssl-dev
  - remnux.packages.libxslt1-dev
  - remnux.packages.libxml2-dev
  - remnux.packages.python-dev
  - remnux.python-packages.pip

remnux-package-mitmproxy:
  pip.installed:
    - name: mitmproxy
    - require:
      - pip: pip
      - pkg: python-dev
      - pkg: libffi-dev
      - pkg: libssl-dev
      - pkg: libxslt1-dev
      - pkg: libxml2-dev
