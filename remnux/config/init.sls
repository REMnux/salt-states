include:
  - remnux.config.docs

remnux-config:
  test.nop:
    - require:
      - sls: remnux.config.docs
