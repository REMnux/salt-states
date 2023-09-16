{%- set remove_plugins = ["malprocfind.py","idxparser.py","chromehistory.py","mimikatz.py","openioc_scan.py","pstotal.py","firefoxhistory.py","autoruns.py","malfinddeep.py","prefetch.py","ssdeepscan.py","uninstallinfo.py","trustrecords.py","usnparser.py","apihooksdeep.py","editbox.py","javarat.py"] -%}

# Name: Volatility Framework
# Website: https://github.com/volatilityfoundation/volatility
# Description: Memory forensics tool and framework
# Category: Perform Memory Forensics
# Author: https://github.com/volatilityfoundation/volatility/blob/2.6.1/AUTHORS.txt
# License: GNU General Public License (GPL) v2: https://github.com/volatilityfoundation/volatility/blob/2.6.1/LICENSE.txt
# Notes: Use vol.py to invoke this version of Volatility. To eliminate conflicts among command-line options for Volatility plugins, the following `yarascan` options have been changed: `-Y` became `-U` and `-C` became `-c`.

include:
  - remnux.packages.git
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip
  - remnux.python-packages.colorama
  - remnux.python-packages.construct
  - remnux.python-packages.dpapick
  - remnux.python-packages.distorm3
  - remnux.python-packages.ioc-writer
  - remnux.python-packages.lxml
  - remnux.python-packages.openpyxl
  - remnux.python-packages.pefile
  - remnux.python-packages.pillow
  - remnux.python-packages.pycoin
  - remnux.python-packages.pycrypto
  - remnux.python-packages.pysocks
  - remnux.python-packages.requests
  - remnux.python-packages.simplejson
  - remnux.python-packages.yara-python

# openpyxl is needed for the timeliner plugin
remnux-python-packages-volatility:
  pip.installed:
    - name: git+https://github.com/volatilityfoundation/volatility.git
    - branch: master
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python2-pip

/usr/bin/vol.py:
  file.symlink:
    - target: /usr/bin/volatility
    - watch:
      - pip: remnux-python-packages-volatility

remnux-python-packages-volatility-community-plugins:
  git.latest:
    - name: https://github.com/sans-dfir/volatility-plugins-community.git
    - target: /usr/local/lib/python2.7/dist-packages/volatility/plugins/community
    - user: root
    - branch: master
    - force_fetch: True
    - force_checkout: True
    - force_clone: True
    - force_reset: True
    - require:
      - pip: remnux-python-packages-volatility
      - sls: remnux.packages.git
      - sls: remnux.python-packages.colorama
      - sls: remnux.python-packages.construct
      - sls: remnux.python-packages.dpapick
      - sls: remnux.python-packages.distorm3
      - sls: remnux.python-packages.ioc-writer
      - sls: remnux.python-packages.lxml
      - sls: remnux.python-packages.openpyxl
      - sls: remnux.python-packages.pefile
      - sls: remnux.python-packages.pillow
      - sls: remnux.python-packages.pycoin
      - sls: remnux.python-packages.pycrypto
      - sls: remnux.python-packages.pysocks
      - sls: remnux.python-packages.requests
      - sls: remnux.python-packages.simplejson
      - sls: remnux.python-packages.yara-python

remnux-python-packages-volatility-malfind-yarascan-options1:
  file.replace:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/malware/malfind.py
    - pattern: short_option = 'C'
    - repl: short_option = 'c'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - git: remnux-python-packages-volatility-community-plugins

remnux-python-packages-volatility-malfind-yarascan-options2:
  file.replace:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/malware/malfind.py
    - pattern: short_option = 'Y'
    - repl: short_option = 'U'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - file: remnux-python-packages-volatility-malfind-yarascan-options1

{% for plugin in remove_plugins -%}

remnux-python-packages-volatility-plugins-{{ plugin }}-absent:
  file.absent:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/{{ plugin }}
    - watch:
      - git: remnux-python-packages-volatility-community-plugins
      - pip: remnux-python-packages-volatility

{% endfor -%}

remnux-python-packages-volatility-mimikatz-plugin-update:
  file.managed:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/community/FrancescoPicasso/mimikatz.py
    - source: https://github.com/RealityNet/hotoloti/raw/master/volatility/mimikatz.py
    - source_hash: sha256=75e2e6d3b09daffad83211ba0215ed3f204623b8c37c2a2950665b88a3d2ce86
    - mode: 644
    - watch:
      - git: remnux-python-packages-volatility-community-plugins
      - pip: remnux-python-packages-volatility

remnux-python-packages-volatility-pstotal:
  file.managed:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/sift/pstotal.py
    - source: https://github.com/teamdfir/sift-saltstack/raw/master/sift/files/volatility/pstotal.py
    - source_hash: sha256=aaa88ce1fe88576f471e2ce40ea21c3e988bba642853df3000776c06320c0582
    - mode: 644
    - makedirs: True
    - watch:
      - pip: remnux-python-packages-volatility

remnux-python-packages-volatility-pstotal-init:
  file.managed:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/sift/__init__.py
    - mode: 644
    - replace: False
    - watch:
      - file: remnux-python-packages-volatility-pstotal

remnux-python-packages-volatility-chromehistory-plugin-update:
  file.managed:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/community/DaveLasalle/chromehistory.py
    - source: https://github.com/superponible/volatility-plugins/raw/master/chromehistory.py
    - source_hash: sha256=6d4f76ae380f7b581fb2a3d2c1620623461d5c0975a21c76d2f40948f7f68b4a
    - mode: 644
    - replace: True
    - watch:
      - git: remnux-python-packages-volatility-community-plugins
      - pip: remnux-python-packages-volatility
