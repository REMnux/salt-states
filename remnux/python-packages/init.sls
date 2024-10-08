include:
  - remnux.python-packages.bitstring
  - remnux.python-packages.bottle
  - remnux.python-packages.cryptography
  - remnux.python-packages.distorm3
  - remnux.python-packages.fuzzywuzzy
  - remnux.python-packages.ndg-httpsclient
  - remnux.python-packages.olefile
  - remnux.python-packages.pydeep
  - remnux.python-packages.pygeoip
  - remnux.python-packages.pypdns
  - remnux.python-packages.pypssl
  - remnux.python-packages.requesocks
  - remnux.python-packages.setuptools
  - remnux.python-packages.shodan
  - remnux.python-packages.six
  - remnux.python-packages.wheel
  - remnux.python-packages.peepdf
  - remnux.python-packages.pype32
  - remnux.python-packages.vipermonkey
  - remnux.python-packages.volatility
  - remnux.python-packages.ioc-writer
  - remnux.python-packages.balbuzard
  - remnux.python-packages.poster
#  - remnux.python-packages.fakenet-ng

remnux-python-packages:
  test.nop:
    - require:
      - sls: remnux.python-packages.bitstring
      - sls: remnux.python-packages.bottle
      - sls: remnux.python-packages.cryptography
      - sls: remnux.python-packages.distorm3
      - sls: remnux.python-packages.fuzzywuzzy
      - sls: remnux.python-packages.ndg-httpsclient
      - sls: remnux.python-packages.olefile
      - sls: remnux.python-packages.pydeep
      - sls: remnux.python-packages.pygeoip
      - sls: remnux.python-packages.pypdns
      - sls: remnux.python-packages.pypssl
      - sls: remnux.python-packages.requesocks
      - sls: remnux.python-packages.setuptools
      - sls: remnux.python-packages.shodan
      - sls: remnux.python-packages.six
      - sls: remnux.python-packages.wheel
      - sls: remnux.python-packages.peepdf
      - sls: remnux.python-packages.pype32
      - sls: remnux.python-packages.vipermonkey
      - sls: remnux.python-packages.volatility
      - sls: remnux.python-packages.ioc-writer
      - sls: remnux.python-packages.balbuzard
      - sls: remnux.python-packages.poster
#      - sls: remnux.python-packages.fakenet-ng
