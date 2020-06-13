include:
  - remnux.packages.python-pip
  - remnux.packages.swig
  - remnux.packages.libssl-dev

remnux-python-packages-m2crypto:
  pip.installed:
    - name: m2crypto
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.swig
      - sls: remnux.packages.libssl-dev