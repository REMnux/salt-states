# Name: SSView
# Website: https://www.mitec.cz/ssv.html
# Description: Analyze OLE2 Structured Storage files.
# Category: Analyze Documents: Microsoft Office
# Author: Michal Mutl
# License: Free to use for private, educational and non-commercial purposes.
# Architecture: amd64
# Arm64: Use oledir or olebrowse from oletools instead.
# Notes: ssview

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-tools-ssview-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: SSView is not available for this architecture."

{% else %}

include:
  - remnux.packages.wine

remnux-tools-ssview-source:
  file.managed:
    - name: /usr/local/src/remnux/files/SSView.zip
    - source: https://www.mitec.cz/wp/files/SSView.zip
    - source_hash: e9d05067745a4f114b22dc798c7fa99017302b39bc8798853ed1bfd4c44d27ab
    - makedirs: True
    - require:
      - sls: remnux.packages.wine

remnux-tools-ssview-archive:
  archive.extracted:
    - name: /usr/local/ssview
    - source: /usr/local/src/remnux/files/SSView.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-tools-ssview-source

remnux-tools-ssview-wrapper:
  file.managed:
    - name: /usr/local/bin/ssview
    - mode: 755
    - watch:
      - archive: remnux-tools-ssview-archive
    - contents:
      - '#!/bin/bash'
      - wine /usr/local/ssview/SSView.exe ${*}

{% endif %}
