# Name: Viper
# Website: https://github.com/viper-framework/viper
# Description: Organize and query a collection of malware samples.
# Category: Gather and Analyze Data
# Author: Claudio Guarnieri: https://nex.sx
# License: BSD 3-Clause License: https://github.com/viper-framework/viper/blob/master/LICENSE
# Notes: Run the tool using the `viper` command. The first time you activate the tool, specify the `update-modules` command within it to download and update community modules from the tool's repository.

include:
  - remnux.packages.libssl-dev
  - remnux.packages.swig
  - remnux.packages.libusb-1
  - remnux.packages.libfuzzy-dev
  - remnux.packages.git
  - remnux.packages.virtualenv
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-venv

remnux-python-packages-viper-virtualenv:
  virtualenv.managed:
    - name: /opt/viper
    - venv_bin: /usr/bin/virtualenv
    - python: /usr/bin/python3
    - pip_pkgs:
      - pip
      - setuptools
      - wheel
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.python3-venv
      - sls: remnux.packages.virtualenv

remnux-python-packages-viper-install:
  pip.installed:
    - name: viper-framework
    - bin_env: /opt/viper/bin/python3
    - require:
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.swig
      - sls: remnux.packages.libusb-1
      - sls: remnux.packages.libfuzzy-dev
      - sls: remnux.packages.git
      - sls: remnux.packages.python3-pip
      - virtualenv: remnux-python-packages-viper-virtualenv

remnux-python-packages-viper-requirements:
  pip.installed:
    - name: jsonschema<4.0.0,>=3.2.0
    - editable: git+https://github.com/viper-framework/xxxswf.git@9188316eb7a179326d99bfde9fe0184bb3cee6a3#egg=xxxswf
    - editable: git+https://github.com/viper-framework/ScrapySplashWrapper.git#egg=ScrapySplashWrapper
    - editable: git+https://github.com/sebdraven/verify-sigs.git#egg=verify-sigs
    - editable: git+https://github.com/MISP/PyTaxonomies.git#egg=PyTaxonomies
    - editable: git+https://github.com/MISP/PyMISPGalaxies.git#egg=PyMISPGalaxies
    - requirements: https://github.com/viper-framework/viper-modules/raw/master/requirements.txt
    - bin_env: /opt/viper/bin/pip3

remnux-python-packages-viper-update-fix:
  file.replace:
    - name: /opt/viper/lib/python3.6/site-packages/viper/core/ui/cmd/update-modules.py
    - pattern: pip3
    - repl: /opt/viper/bin/pip3
    - count: 1
    - prepend_if_not_found: False
    - require:
      - pip: remnux-python-packages-viper-install

remnux-python-packages-viper-symlink:
  file.symlink:
    - name: /usr/local/bin/viper
    - target: /opt/viper/bin/viper
    - force: true
    - require:
      - pip: remnux-python-packages-viper-install
