include:
  - remnux.config.docs
  - remnux.config.inetsim

remnux-config:
  test.nop:
    - require:
      - sls: remnux.config.docs
      - sls: remnux.config.inetsim
