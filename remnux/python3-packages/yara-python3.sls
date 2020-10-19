include:
  - remnux.packages.python3-pip

remnux-python-packages-yara-python3:
  pip.installed:
    - name: "yara-python"
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip
