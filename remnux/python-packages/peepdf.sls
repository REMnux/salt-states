# Source: http://peepdf.eternal-todo.com/
# Author: Jose Miguel Esparza

# For JavaScript deobfuscation peepef requires pyv8. However, pyv8
# isn't building properly, so I commented it out.

include:
  - remnux.packages.python-pip
  - remnux.packages.python-lxml
  - remnux.packages.libjpeg8-dev
  - remnux.packages.zlib1g-dev
#  - remnux.python-packages.pyv8
  - remnux.python-packages.pylibemu
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-thread-dev

remnux-thug:
  pip.installed:
    - name: peepdf
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python-lxml
      - sls: remnux.packages.libjpeg8-dev
      - sls: remnux.packages.zlib1g-dev
#      - sls: remnux.python-packages.pyv8
      - sls: remnux.python-packages.pylibemu
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.libboost-thread-dev
