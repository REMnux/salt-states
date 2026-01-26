include:
  - remnux.network.prefer-ipv4

remnux-network:
  test.nop:
    - require:
      - sls: remnux.network.prefer-ipv4
