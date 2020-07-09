# Name: Viper
# Website: https://github.com/viper-framework/viper
# Description: Organize and query a collection of malware samples.
# Category: Gather and Analyze Data
# Author: Claudio Guarnieri: https://nex.sx
# License: BSD 3-Clause License: https://github.com/viper-framework/viper/blob/master/LICENSE
# Notes: viper

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
    - pkgs:
      - androguard==3.3.5
      - pyclamd==0.4.0
      - pypdns==1.4.1
      - pyelftools==0.25
      - dnspython==1.16.0
      - olefile==0.46
      - git+https://github.com/viper-framework/xxxswf.git@9188316eb7a179326d99bfde9fe0184bb3cee6a3#egg=xxxswf
      - pyparsing==2.4.7
      - packaging==19.0
      - pefile==2019.4.18
      - bitstring==3.1.7
      - pyasn1==0.4.8
      - pyopenssl==19.1.0
      - cryptography==2.9.2
      - cffi==1.14.0
      - asn1crypto==1.3.0
      - idna==2.9
      - ipaddress==1.0.23
      - pycparser==2.20
      - pypssl==2.1
      - r2pipe==1.2.0
      - beautifulsoup4==4.7.1
      - pylzma==0.5.0
      - virustotal-api==1.1.10
      - yara-python==3.10.0
      - pycrypto==2.6.1
      - git+https://github.com/viper-framework/ScrapySplashWrapper.git#egg=ScrapySplashWrapper
      - git+https://github.com/sebdraven/verify-sigs.git#egg=verify-sigs
      - oletools==0.54.1
      - git+https://github.com/MISP/PyTaxonomies.git#egg=PyTaxonomies
      - git+https://github.com/MISP/PyMISPGalaxies.git#egg=PyMISPGalaxies
      - ocrd-pyexiftool==0.2.0
      - jbxapi>=3.1.3,<4
      - pymisp[fileobjects,virustotal] >= 2.4.96
      - jsonschema<4.0.0,>=3.2.0
      - lief==0.10.1
      - snoopdroid==2.1
    - bin_env: /opt/viper/bin/python3
    - require:
      - pip: remnux-python-packages-viper-install
    - watch:
      - pip: remnux-python-packages-viper-install

remnux-python-packages-viper-symlink:
  file.symlink:
    - name: /usr/local/bin/viper
    - target: /opt/viper/bin/viper
    - require:
      - pip: remnux-python-packages-viper-install
