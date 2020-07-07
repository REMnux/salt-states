include:
  - remnux.node-packages.box-js

remnux-node-packages:
  test.nop:
    - require:
      - sls: remnux.node-packages.box-js
