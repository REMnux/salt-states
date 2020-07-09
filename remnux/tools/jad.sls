# Name: JAD Java Decompiler
# Website: Unknown
# Description: Java decompiler and analysis tool
# Category: Statically Analyze Code: Java
# Author: Pavel Kouznetsov
# License: Free, unknown license
# Notes: jad

remnux-tools-jad-source:
  file.managed:
    - name: /usr/local/src/remnux/files/jad-1.5.8-elf-32.zip
    - source: https://github.com/remnux/distro/raw/master/files/jad-1.5.8-elf-32.zip
    - source_hash: sha256=6cf209ea820651a7b6bb5b265203692c053bcf788e76939b0f596a510591b919
    - makedirs: true

remnux-tools-jad-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/jad-1.5.8
    - source: /usr/local/src/remnux/files/jad-1.5.8-elf-32.zip
    - enforce_toplevel: false
    - watch:
      - file: remnux-tools-jad-source

remnux-tools-jad-binary:
  file.managed:
    - name: /usr/local/bin/jad
    - source: /usr/local/src/remnux/jad-1.5.8/jad
    - mode: 755
    - watch:
      - archive: remnux-tools-jad-archive
