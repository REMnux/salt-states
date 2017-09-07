include:
  - remnux.python-packages.pip

remnux-pip-thug:
  pip.installed:
    - name: thug
    - require:
      - sls: remnux.python-packages.pip
