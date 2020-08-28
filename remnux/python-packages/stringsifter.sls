# Name: StringSifter
# Website: https://github.com/fireeye/stringsifter
# Description: Automatically rank strings based on their relevance to the analysis of suspicious Windows executables.
# Category: Examine Static Properties: PE Files
# Author: FireEye Inc.
# License: Apache License 2.0: https://github.com/fireeye/stringsifter/blob/master/LICENSE
# Notes: flarestrings

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.git

remnux-python-packages-stringsifter-source:
  git.cloned:
    - name: https://github.com/fireeye/stringsifter.git
    - target: /usr/local/src/stringsifter
    - require:
      - sls: remnux.packages.git

remnux-python-packages-stringsifter-requirements-lightgbm:
  file.replace:
    - name: /usr/local/src/stringsifter/requirements.txt
    - pattern: lightgbm==2.1.2
    - repl: lightgbm~=2.1.2
    - count: 1
    - prepend_if_not_found: false
    - require:
      - git: remnux-python-packages-stringsifter-source

remnux-python-packages-stringsifter-requirements-numpy:
  file.replace:
    - name: /usr/local/src/stringsifter/requirements.txt
    - pattern: numpy==1.17.1
    - repl: numpy~=1.19.1
    - count: 1
    - prepend_if_not_found: false
    - require:
      - git: remnux-python-packages-stringsifter-source

remnux-python-packages-stringsifter-requirements-joblib:
  file.replace:
    - name: /usr/local/src/stringsifter/requirements.txt
    - pattern: joblib==0.13.2
    - repl: joblib
    - count: 1
    - prepend_if_not_found: false
    - require:
      - git: remnux-python-packages-stringsifter-source

remnux-python-packages-stringsifter-requirements-pytest:
  file.replace:
    - name: /usr/local/src/stringsifter/requirements.txt
    - pattern: pytest==3.10.1
    - repl: pytest
    - count: 1
    - prepend_if_not_found: false
    - require:
      - git: remnux-python-packages-stringsifter-source

remnux-python-packages-stringsifter-requirements-fasttext:
  file.replace:
    - name: /usr/local/src/stringsifter/requirements.txt
    - pattern: fasttext==0.9.1
    - repl: fasttext
    - count: 1
    - prepend_if_not_found: false
    - require:
      - git: remnux-python-packages-stringsifter-source

remnux-python-packages-stringsifter:
  pip.installed:
    - name: /usr/local/src/stringsifter
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip    
