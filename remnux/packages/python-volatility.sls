include:
  - remnux.repos.sift
  - remnux.python-packages.distorm3
  - remnux.python-packages.pefile
  - remnux.python-packages.yara-python

python-volatility:
  pkg.installed:
    - require:
      - pkgrepo: sift-repo
      - sls: remnux.python-packages.distorm3
      - sls: remnux.python-packages.pefile
      - sls: remnux.python-packages.yara-python
