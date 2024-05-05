# Name: apktool
# Website: https://ibotpeaches.github.io/Apktool/
# Description: Reverse-engineer Android APK files.
# Category: Statically Analyze Code: Android
# Author: Connor Tumbleson, Ryszard Wisniewski
# License: Apache License 2.0: https://github.com/iBotPeaches/Apktool/blob/master/LICENSE
# Notes: 

{% set hash = '7956eb04194300ce0d0a84ad18771eebc94b89fb8d1ddcce8ea4c056818646f4' %}
{% set version = '2.9.3' %}

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
    - name: /usr/local/apktool/apktool_{{ version }}.jar
    - source: https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_{{ version }}.jar
    - source_hash: sha256={{ hash }}
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
      - java -jar /usr/local/apktool/apktool_{{ version }}.jar ${*}
