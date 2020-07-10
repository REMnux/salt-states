# Name: DroidLysis
# Website: https://github.com/cryptax/droidlysis
# Description: Perform static analysis of Android applications.
# Category: Statically Analyze Code: Android, Examine Static Properties: General
# Author: cryptax
# License: MIT License: https://github.com/cryptax/droidlysis/blob/master/LICENSE
# Notes: droidlysis3.py

include:
  - remnux.packages.python3-pip
  - remnux.packages.python-pip
  - remnux.tools.apktool
  - remnux.packages.baksmali
  - remnux.packages.dex2jar
  - remnux.packages.procyon-decompiler
  - remnux.packages.unzip

remnux-python-packages-droidlysis:
  pip.installed:
    - name: droidlysis
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.tools.apktool
      - sls: remnux.packages.baksmali
      - sls: remnux.packages.dex2jar
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.procyon-decompiler
      - sls: remnux.packages.unzip

remnux-python-packages-droidlysis-droidconfig-set1:
  file.replace:
    - name: /usr/local/bin/droidconfig.py
    - pattern: '^APKTOOL_JAR.*$'
    - repl: 'APKTOOL_JAR = os.path.join(os.path.expanduser("/usr/local/apktool"), "apktool_2.4.1.jar")'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-droidlysis

remnux-python-packages-droidlysis-droidconfig-set2:
  file.replace:
    - name: /usr/local/bin/droidconfig.py
    - pattern: '^BAKSMALI_JAR.*$'
    - repl: 'BAKSMALI_JAR = os.path.join(os.path.expanduser("/opt/baksmali"), "baksmali-2.4.0.jar")'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-droidlysis

remnux-python-packages-droidlysis-droidconfig-set3:
  file.replace:
    - name: /usr/local/bin/droidconfig.py
    - pattern: '^DEX2JAR_CMD.*$'
    - repl: 'DEX2JAR_CMD = os.path.join(os.path.expanduser("/usr/bin"), "d2j-dex2jar")'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-droidlysis

remnux-python-packages-droidlysis-droidconfig-set4:
  file.replace:
    - name: /usr/local/bin/droidconfig.py
    - pattern: '^PROCYON_JAR.*$'
    - repl: 'PROCYON_JAR = os.path.join(os.path.expanduser("/usr/share/java"), "procyon-decompiler-0.5.32.jar")'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-droidlysis

remnux-python-packages-droidlysis-droidconfig-set5:
  file.replace:
    - name: /usr/local/bin/droidconfig.py
    - pattern: '^INSTALL_DIR.*$'
    - repl: 'INSTALL_DIR = os.path.expanduser("/usr/local/bin")'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - pip: remnux-python-packages-droidlysis