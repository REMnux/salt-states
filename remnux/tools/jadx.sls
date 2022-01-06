# Name: JADX
# Website: https://github.com/skylot/jadx
# Description: Generate Java source code from Dalvik Executable (dex) and Android APK files
# Category: Statically Analyze Code: Android
# Author: Skylot
# License: Apache License 2.0: https://github.com/skylot/jadx/blob/master/LICENSE, also see https://github.com/skylot/jadx/blob/master/NOTICE
# Notes: jadx, jadx-gui

include:
  - remnux.packages.default-jdk

remnux-tools-jadx-source:
  file.managed:
    - name: /usr/local/src/remnux/files/jadx-1.3.1.zip
    - source: https://github.com/skylot/jadx/releases/download/v1.3.1/jadx-1.3.1.zip
    - source_hash: sha256=0774347530fa5a008dcc10e3b55f03a72141dd34ffd7e5addee18db06d0a151f
    - makedirs: true
    - require:
      - sls: remnux.packages.default-jdk

remnux-tools-jadx-archive:
  archive.extracted:
    - name: /usr/local/jadx
    - source: /usr/local/src/remnux/files/jadx-1.3.1.zip
    - enforce_toplevel: false
    - watch:
      - file: remnux-tools-jadx-source

remnux-tools-jadx-link1:
  file.symlink:
    - target: /usr/local/jadx/bin/jadx
    - name: /usr/local/bin/jadx
    - mode: 755
    - watch:
      - archive: remnux-tools-jadx-archive

remnux-tools-jadx-link2:
  file.symlink:
    - target: /usr/local/jadx/bin/jadx-gui
    - name: /usr/local/bin/jadx-gui
    - mode: 755
    - watch:
      - archive: remnux-tools-jadx-archive
