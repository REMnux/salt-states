include:
  - remnux.python-packages.pip

mitmproxy:
  pip.installed:
    - require:
      - pip: pip
