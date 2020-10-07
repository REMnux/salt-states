{%- set remove_plugins = ["malprocfind.py","idxparser.py","chromehistory.py","mimikatz.py","openioc_scan.py","pstotal.py","firefoxhistory.py","autoruns.py","malfinddeep.py","prefetch.py","ssdeepscan.py","uninstallinfo.py","trustrecords.py","usnparser.py","apihooksdeep.py","editbox.py","javarat.py"] -%}

# Name: Volatility Framework
# Website: https://github.com/volatilityfoundation/volatility
# Description: Memory forensics tool and framework
# Category: Perform Memory Forensics
# Author: https://github.com/volatilityfoundation/volatility/blob/2.6.1/AUTHORS.txt
# License: GNU General Public License (GPL) v2: https://github.com/volatilityfoundation/volatility/blob/2.6.1/LICENSE.txt
# Notes: vol.py

# This file is based directly on github.com/teamdfir/sift-saltstack/blob/master/sift/python-packages/volatility_bionic.sls

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.python-packages.colorama
  - remnux.python-packages.construct
  - remnux.python-packages.dpapick
  - remnux.python-packages.distorm3
  - remnux.python-packages.haystack
  - remnux.python-packages.ioc-writer
  - remnux.python-packages.lxml
  - remnux.python-packages.pefile
  - remnux.python-packages.pycoin
  - remnux.python-packages.pysocks
  - remnux.python-packages.simplejson
  - remnux.python-packages.yara-python
  - remnux.python-packages.requests
  - remnux.python-packages.openpyxl
  - remnux.packages.python3-pip

# openpyxl is needed for the timeliner plugin
remnux-python-packages-volatility:
  pip.installed:
    - name: git+https://github.com/volatilityfoundation/volatility.git@master
    - bin_env: /usr/bin/python
    - upgrade: True
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.python-packages.openpyxl

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
      - sls: remnux.python-packages.haystack
      - sls: remnux.python-packages.ioc-writer
      - sls: remnux.python-packages.lxml
      - sls: remnux.python-packages.pefile
      - sls: remnux.python-packages.pycoin
      - sls: remnux.python-packages.pysocks
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
