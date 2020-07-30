include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

# distorm3 v3.5.0 breaks Volatility 2.6.1, so we're installing distorm3 v3.4.4
distorm3==3.4.4:
  pip.installed:
    - bin_env: /usr/bin/python
    - require:
      - sls: remnux.packages.python-pip
