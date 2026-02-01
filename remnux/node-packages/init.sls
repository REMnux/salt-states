include:
  - remnux.node-packages.box-js
  - remnux.node-packages.jstillery
  - remnux.node-packages.opencode

remnux-node-packages:
  test.nop:
    - require:
      - sls: remnux.node-packages.box-js
      - sls: remnux.node-packages.jstillery
      - sls: remnux.node-packages.opencode