# Source: https://github.com/fireeye/flare-floss
# Author: FireEye, Inc.

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.python-packages.vivisect

remnux-pip-flare-floss:
  pip.installed:
    - name: git+https://github.com/fireeye/flare-floss.git@master
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.python-packages.vivisect
