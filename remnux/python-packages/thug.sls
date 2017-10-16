# Source: https://github.com/buffer/thug
# Author: Angelo Dell'Aera

include:
  - remnux.python-packages.pip
  - remnux.packages.build-essential
  - remnux.packages.python-dev
  - remnux.packages.python-setuptools
  - remnux.packages.libboost-python-dev
  - remnux.packages.libboost-all-dev
  - remnux.packages.python-pip
  - remnux.packages.libxml2-dev
  - remnux.packages.libxslt-dev
  - remnux.packages.libtool
  - remnux.packages.graphviz-dev
  - remnux.packages.automake
  - remnux.packages.libffi-dev
  - remnux.packages.graphviz
  - remnux.packages.libfuzzy-dev
  - remnux.packages.libjpeg-dev
  - remnux.packages.pkg-config
  - remnux.packages.autoconf
  - remnux.packages.libemu-dev
  - remnux.python-packages.pyv8
  - remnux.python-packages.pygraphviz

remnux-thug:
  pip.installed:
    - name: git+https://github.com/buffer/thug.git@master
    - require:
      - sls: remnux.python-packages.pip
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.python-dev
      - sls: remnux.packages.python-setuptools
      - sls: remnux.packages.libboost-python-dev
      - sls: remnux.packages.libboost-all-dev
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.libxml2-dev
      - sls: remnux.packages.libxslt-dev
      - sls: remnux.packages.libtool
      - sls: remnux.packages.graphviz-dev
      - sls: remnux.packages.automake
      - sls: remnux.packages.libffi-dev
      - sls: remnux.packages.graphviz
      - sls: remnux.packages.libfuzzy-dev
      - sls: remnux.packages.libjpeg-dev
      - sls: remnux.packages.pkg-config
      - sls: remnux.packages.autoconf
      - sls: remnux.packages.libemu-dev
      - sls: remnux.python-packages.pyv8
      - sls: remnux.python-packages.pygraphviz
