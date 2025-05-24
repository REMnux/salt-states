# Name: DC3-mwcp
# Website: https://github.com/Defense-Cyber-Crime-Center/DC3-mwcp
# Description: Parsing configuration information from malware.
# Category: Examine Static Properties: Deobfuscation
# Author: Defense Cyber Crime Center - United States Government
# License: Some parts Public Domain, some MIT License: https://github.com/Defense-Cyber-Crime-Center/DC3-mwcp/blob/master/LICENSE.txt
# Notes: mwcp

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-dc3-mwcp-venv:
  virtualenv.managed:
    - name: /opt/mwcp
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-dc3-mwcp:
  pip.installed:
    - name: mwcp
    - bin_env: /opt/mwcp/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-dc3-mwcp-venv

remnux-python3-packages-dc3-mwcp-symlink:
  file.symlink:
    - name: /usr/local/bin/mwcp
    - target: /opt/mwcp/bin/mwcp
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-dc3-mwcp
