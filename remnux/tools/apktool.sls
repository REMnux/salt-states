# Name: apktool
# Website: https://ibotpeaches.github.io/Apktool/
# Description: Reverse-engineer Android APK files.
# Category: Statically Analyze Code: Android
# Author: Connor Tumbleson, Ryszard Wisniewski
# License: Apache License 2.0: https://github.com/iBotPeaches/Apktool/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.default-jre

remnux-tools-apktool-directory:
  file.directory:
    - name: /usr/local/apktool/
    - user: root
    - group: root
    - mode: 755
    - makedirs: true

remnux-tools-apktool-source:
  file.managed:
    - name: /usr/local/apktool/apktool_2.4.1.jar
    - source: https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.4.1.jar
    - source_hash: sha256=bdeb66211d1dc1c71f138003ce35f6d0cd19af6f8de7ffbdd5b118d02d825a52
    - mode: 755
    - watch:
      - file: remnux-tools-apktool-directory
    - require:
      - file: remnux-tools-apktool-directory

remnux-tools-apktool-wrapper:
  file.managed:
    - name: /usr/local/bin/apktool
    - mode: 755
    - watch:
      - file: remnux-tools-apktool-source
    - contents:
      - '#!/bin/bash'
      - java -jar /usr/local/apktool/apktool_2.4.1.jar ${*}
