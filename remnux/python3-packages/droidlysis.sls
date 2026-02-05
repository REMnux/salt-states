# Name: DroidLysis
# Website: https://github.com/cryptax/droidlysis
# Description: Perform static analysis of Android applications.
# Category: Statically Analyze Code: Android, Examine Static Properties: General
# Author: cryptax
# License: MIT License: https://github.com/cryptax/droidlysis/blob/master/LICENSE
# Notes: droidlysis
{%- set python3_version="python3.12" %}
{% set apktool_ver = '2.11.1' %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.tools.apktool
  - remnux.packages.baksmali
  - remnux.packages.dex2jar
  - remnux.packages.procyon-decompiler
  - remnux.packages.unzip

remnux-python3-packages-droidlysis-venv:
  virtualenv.managed:
    - name: /opt/droidlysis
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - typing-extensions>=4.5.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-droidlysis:
  pip.installed:
    - name: droidlysis
    - bin_env: /opt/droidlysis/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-droidlysis-venv

remnux-python3-packages-droidlysis-symlink:
  file.symlink:
    - name: /usr/local/bin/droidlysis
    - target: /opt/droidlysis/bin/droidlysis
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-droidlysis

remnux-python-packages-droidlysis-droidconfig-set1:
  file.replace:
    - name: /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/general.conf
    - pattern: '^apktool =.*$'
    - repl: 'apktool = /usr/local/apktool/apktool_{{ apktool_ver }}.jar'
    - prepend_if_not_found: False
    - count: 1
    - backup: False
    - require:
      - pip: remnux-python3-packages-droidlysis

remnux-python-packages-droidlysis-droidconfig-set2:
  file.replace:
    - name: /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/general.conf
    - pattern: '^baksmali =.*$'
    - repl: 'baksmali = /opt/baksmali/baksmali-2.4.0.jar'
    - prepend_if_not_found: False
    - count: 1
    - backup: False
    - require:
      - pip: remnux-python3-packages-droidlysis

remnux-python3-packages-droidlysis-droidconfig-set3:
  file.replace:
    - name: /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/general.conf
    - pattern: '^dex2jar =.*$'
    - repl: 'dex2jar = /usr/bin/d2j-dex2jar'
    - prepend_if_not_found: False
    - count: 1
    - backup: False
    - require:
      - pip: remnux-python3-packages-droidlysis

remnux-python3-packages-droidlysis-droidconfig-set4:
  file.replace:
    - name: /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/general.conf
    - pattern: '^procyon =.*$'
    - repl: 'procyon = /usr/share/java/procyon-decompiler-0.5.32.jar'
    - prepend_if_not_found: False
    - count: 1
    - backup: False
    - require:
      - pip: remnux-python3-packages-droidlysis

remnux-python3-packages-droidlysis-droidconfig-set5:
  file.replace:
    - name: /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/general.conf
    - pattern: '^smali_config =.*$'
    - repl: 'smali_config = /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/smali.conf'
    - prepend_if_not_found: False
    - count: 1
    - backup: False
    - require:
      - pip: remnux-python3-packages-droidlysis

remnux-python3-packages-droidlysis-droidconfig-set6:
  file.replace:
    - name: /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/general.conf
    - pattern: '^wide_config =.*$'
    - repl: 'wide_config = /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/wide.conf'
    - prepend_if_not_found: False
    - count: 1
    - backup: False
    - require:
      - pip: remnux-python3-packages-droidlysis

remnux-python3-packages-droidlysis-droidconfig-set7:
  file.replace:
    - name: /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/general.conf
    - pattern: '^arm_config =.*$'
    - repl: 'arm_config = /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/arm.conf'
    - prepend_if_not_found: False
    - count: 1
    - backup: False
    - require:
      - pip: remnux-python3-packages-droidlysis

remnux-python3-packages-droidlysis-droidconfig-set8:
  file.replace:
    - name: /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/general.conf
    - pattern: '^kit_config =.*$'
    - repl: 'kit_config = /opt/droidlysis/lib/{{ python3_version }}/site-packages/conf/kit.conf'
    - prepend_if_not_found: False
    - count: 1
    - backup: False
    - require:
      - pip: remnux-python3-packages-droidlysis
