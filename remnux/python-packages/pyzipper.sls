include:
  - remnux.packages.python3-pip
  - remnux.packages.python-pip

remnux-python-packages-pyzipper:
  pip.installed:
    - name: pyzipper
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.packages.python3-pip