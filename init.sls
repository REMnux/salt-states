include:
  - remnux.repos
  - remnux.packages
  - remnux.python-packages
  - remnux.rubygems
  - remnux.config

remnux:
  test.nop:
    - require:
      - sls: remnux.repos
      - sls: remnux.packages
      - sls: remnux.python-packages
      - sls: remnux.rubygems
      - sls: remnux.config
      
