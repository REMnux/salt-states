# Name: DroidLysis
# Website: https://github.com/cryptax/droidlysis
# Description: Perform static analysis of Android applications.
# Category: Statically Analyze Code: Android, Examine Static Properties: General
# Author: cryptax
# License: MIT License: https://github.com/cryptax/droidlysis/blob/master/LICENSE
# Notes: droidlysis
{%- if grains['oscodename'] == "bionic" %}
  {%- set python3_version="python3.6" %}
{%- elif grains['oscodename'] == "focal" %}
  {%- set python3_version="python3.8" %}
{% endif %}

include:
  - remnux.python3-packages.pip
  - remnux.python3-packages.typing-extensions
  - remnux.tools.apktool
  - remnux.packages.baksmali
  - remnux.packages.dex2jar
  - remnux.packages.procyon-decompiler
  - remnux.packages.unzip

remnux-python-packages-droidlysis:
  pip.installed:
    - name: droidlysis
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.tools.apktool
      - sls: remnux.packages.baksmali
      - sls: remnux.packages.dex2jar
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.procyon-decompiler
      - sls: remnux.packages.unzip
      - sls: remnux.python3-packages.typing-extensions

remnux-python-packages-droidlysis-droidconfig-set1:
  file.replace:
    - name: /usr/local/lib/{{ python3_version }}/dist-packages/conf/general.conf
    - pattern: '^apktool =.*$'
    - repl: 'apktool = /usr/local/apktool/apktool_2.7.0.jar'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-droidlysis

remnux-python-packages-droidlysis-droidconfig-set2:
  file.replace:
    - name: /usr/local/lib/{{ python3_version }}/dist-packages/conf/general.conf
    - pattern: '^baksmali =.*$'
    - repl: 'baksmali = /opt/baksmali/baksmali-2.4.0.jar'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-droidlysis

remnux-python-packages-droidlysis-droidconfig-set3:
  file.replace:
    - name: /usr/local/lib/{{ python3_version }}/dist-packages/conf/general.conf
    - pattern: '^dex2jar =.*$'
    - repl: 'dex2jar = /usr/bin/d2j-dex2jar'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-droidlysis

remnux-python-packages-droidlysis-droidconfig-set4:
  file.replace:
    - name: /usr/local/lib/{{ python3_version }}/dist-packages/conf/general.conf
    - pattern: '^procyon =.*$'
    - repl: 'procyon = /usr/share/java/procyon-decompiler-0.5.32.jar'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-droidlysis
