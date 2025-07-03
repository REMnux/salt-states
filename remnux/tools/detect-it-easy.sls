# Name: Detect-It-Easy
# Website: https://github.com/horsicq/Detect-It-Easy
# Description: Determine types of files and examine file properties.
# Category: Examine Static Properties: General
# Author: hors: https://twitter.com/horsicq
# License: MIT License: https://github.com/horsicq/Detect-It-Easy/blob/master/LICENSE
# Notes: GUI tool: `die`, command-line tool: `diec`.

{% set version = '3.10' %}
{% if grains['oscodename'] == "focal" %}
{% set release = '20.04' %}
{% set hash = 'b555c8b20ef126dce75bce9b9a0615594b7864d1c2de9fd3cc6ea5b1fcc6e7e8' %}
{% set qtpkg = "qt5-default" %}
{% elif grains['oscodename'] == "noble" %}
{% set release = '24.04' %}
{% set hash = 'a64d32fcd95ab5c25cfb01f2e0355f67737eff93d6ae34c80b2b3dbdee721b1b' %}
{% set qtpkg = "qtbase5-dev" %}
{% endif %}

include:
  - remnux.packages.libglib2
  - remnux.packages.{{ qtpkg }}
  - remnux.packages.libqt5scripttools5

remnux-tools-detect-it-easy-source:
  file.managed:
    - name: /usr/local/src/remnux/files/die_{{ version }}_Ubuntu_{{ release }}_amd64.deb
    - source: https://github.com/horsicq/DIE-engine/releases/download/{{ version }}/die_{{ version }}_Ubuntu_{{ release }}_amd64.deb
    - source_hash: sha256={{ hash }}
    - makedirs: true

remnux-tools-detect-it-easy-cleanup1:
  file.absent:
    - name: /usr/local/bin/die
    - require:
      - file: remnux-tools-detect-it-easy-source

remnux-tools-detect-it-easy-cleanup2:
  file.absent:
    - name: /usr/local/bin/diec
    - require:
      - file: remnux-tools-detect-it-easy-cleanup1

remnux-tools-detect-it-easy-install:
  pkg.installed:
    - sources:
      - detectiteasy: /usr/local/src/remnux/files/die_{{ version }}_Ubuntu_{{ release }}_amd64.deb
    - require:
      - file: remnux-tools-detect-it-easy-cleanup2
      - sls: remnux.packages.libglib2
      - sls: remnux.packages.{{ qtpkg }}
      - sls: remnux.packages.libqt5scripttools5
