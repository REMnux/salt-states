include:
  - remnux.python-packages.pip

six:
  pip.installed:
    - name: six >= 1.6
    - upgrade: True
    - require:
      - pip: pip
