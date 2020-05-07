include:
  - remnux.packages.python-pip

remnux-jsbeautifier:
  pip.installed:
    - name: jsbeautifier
    - require:
      - sls: remnux.packages.python-pip