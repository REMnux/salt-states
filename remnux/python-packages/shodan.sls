include:
  - remnux.packages.python-pip

shodan:
  pip.installed:
    - require:
      - sls: remnux.packages.python-pip
