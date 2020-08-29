include:
  - remnux.packages.python-pip
  - remnux.packages.swig
  - remnux.packages.libssl-dev
  - remnux.packages.python3-pip

remnux-python-packages-m2crypto:
  pip.installed:
    - name: m2crypto
    - bin_env: /usr/bin/python
    - upgrade: True
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.swig
      - sls: remnux.packages.libssl-dev