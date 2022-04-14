include:
  - remnux.python3-packages.pip

remnux-python-packages-yara-python3:
  pip.installed:
    - name: "yara-python"
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
