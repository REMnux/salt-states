include:
  - remnux.repos
  - remnux.packages
  - remnux.python-packages
  - remnux.rubygems
  - remnux.scripts
  - remnux.config
  - remnux.tools

remnux:
  test.nop:
    - require:
      - sls: remnux.repos
      - sls: remnux.packages
      - sls: remnux.python-packages
      - sls: remnux.rubygems
      - sls: remnux.scripts
      - sls: remnux.config
      - sls: remnux.tools
