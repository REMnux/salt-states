# Name: SpiderMonkey (Patched)
# Website: https://blog.didierstevens.com/2018/04/19/update-patched-spidermonkey/
# Description: Execute and deobfuscate JavaScript using a patched version of Mozilla's standalone JavaScript engine.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: SpiderMonkey by Mozilla Foundation, patched by Didier Stevens: https://twitter.com/DidierStevens
# License: Mozilla Public License 2.0: https://github.com/mozilla/treeherder/blob/master/LICENSE.txt
# Notes: js-ascii, js-file

include:
  - remnux.packages.i386-architecture

remnux-tools-js-patched-source:
  file.managed:
    - name: /usr/local/src/remnux/files/js-1.7.0-mod-c.zip
    - source: https://didierstevens.com/files/software/js-1.7.0-mod-c.zip
    - source_hash: 2ccb2f57df706a8ee689c54b18a0ea7bb052ef08ba233f1319119825db32927b
    - makedirs: True
    - require:
      - sls: remnux.packages.i386-architecture

remnux-tools-js-patched-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/js-1.7.0-mod-c
    - source: /usr/local/src/remnux/files/js-1.7.0-mod-c.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-tools-js-patched-source

remnux-tools-js-patched-binary1:
  file.managed:
    - name: /usr/local/bin/js-file
    - source: /usr/local/src/remnux/js-1.7.0-mod-c/js-1.7.0-mod-c/Linux/js-file
    - mode: 755
    - watch:
      - archive: remnux-tools-js-patched-archive

/usr/local/bin/js-patched:
  file.symlink:
  - target: /usr/local/bin/js-file
  - watch:
    - file: remnux-tools-js-patched-binary1

remnux-tools-js-patched-binary2:
  file.managed:
    - name: /usr/local/bin/js-ascii
    - source: /usr/local/src/remnux/js-1.7.0-mod-c/js-1.7.0-mod-c/Linux/js-ascii
    - mode: 755
    - watch:
      - archive: remnux-tools-js-patched-archive