include:
  - remnux.python-packages.pip

remnux-jsbeautifier:
  pip.installed:
    - name: jsbeautifier
    - require:
      - pip: pip
