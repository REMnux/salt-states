include:
  - remnux.packages.python3-pip
  - remnux.python3-packages.chepy
  - remnux.python3-packages.malwoverview
  - remnux.python3-packages.msoffcrypto-tool
  - remnux.python3-packages.olefile
  - remnux.python3-packages.oletools
  - remnux.python3-packages.pcodedmp
  - remnux.python3-packages.peframe
  - remnux.python3-packages.protobuf
  - remnux.python3-packages.setuptools
  - remnux.python3-packages.wheel

remnux-python3-packages-pypi-upgrade:
  cmd.run:
    - name: /usr/bin/python3 -m pip install --upgrade chepy chepy[extras] msoffcrypto-tool olefile oletools pcodedmp protobuf setuptools wheel

remnux-python3-packages-git-upgrade:
  cmd.run:
    - name: /usr/bin/python3 -m pip install --upgrade git+https://github.com/guelfoweb/peframe.git@master

remnux-python3-packages-malwoverview-upgrade:
  cmd.run:
    - name: /opt/malwoverview/bin/python3 -m pip install --upgrade malwoverview
