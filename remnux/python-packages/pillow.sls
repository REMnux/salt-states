include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip

remnux-python-packages-pillow:
  pip.installed:
    - name: pillow
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip
