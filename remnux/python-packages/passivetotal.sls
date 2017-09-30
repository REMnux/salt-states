include:
  - remnux.packages.python-pip

remnux-python-passivetotal:
  pip.installed:
    - name: passivetotal
    - require:
      - sls: remnux.packages.python-pip
