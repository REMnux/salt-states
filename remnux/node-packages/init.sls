include:
  - remnux.node-packages.box-js

remnux-node-packages-npm:
  pkg.installed:
    - name: npm

remnux-node-packages:
  test.nop:
    - require:
      - sls: remnux.node-packages.box-js
