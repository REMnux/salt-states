include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-yara-x-venv:
  virtualenv.managed:
    - name: /opt/yara-x
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-yara-x:
  pip.installed:
    - name: yara-x
    - bin_env: /opt/yara-x/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-yara-x-venv
