include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

# The version below is needed by stringsifter, but the
# malwoverview dependency polyswarm-api downgrades it.
pytest==3.10.1:
  pip.installed:
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip