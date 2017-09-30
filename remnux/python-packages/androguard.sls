# Source: https://github.com/androguard/androguard

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.packages.ipython
  - remnux.packages.python-cryptography
  - remnux.packages.python-future
  - remnux.packages.python-magic
  - remnux.packages.python-networkx
  - remnux.packages.python-pyasn1
  - remnux.packages.python-pydot
  - remnux.packages.python-pyperclip
  - remnux.packages.python-pyqt5

remnux-python-androguard:
  pip.installed:
    - name: git+https://github.com/androguard/androguard.git@cf8cc39
    - require:
      - pkg: git
      - pkg: python-pip
      - sls: remnux.packages.ipython
      - sls: remnux.packages.python-cryptography
      - sls: remnux.packages.python-future
      - sls: remnux.packages.python-magic
      - sls: remnux.packages.python-networkx
      - sls: remnux.packages.python-pyasn1
      - sls: remnux.packages.python-pydot
      - sls: remnux.packages.python-pyperclip
      - sls: remnux.packages.python-pyqt5
      
