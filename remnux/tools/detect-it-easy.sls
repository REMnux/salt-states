# Name: Detect-It-Easy
# Website: https://github.com/horsicq/Detect-It-Easy
# Description: Determine types of files and examine file properties.
# Category: Examine Static Properties: General
# Author: hors: https://twitter.com/horsicq
# License: MIT License: https://github.com/horsicq/Detect-It-Easy/blob/master/LICENSE
# Notes: GUI tool: `die`, command-line tool: `diec`.

{% set version = '3.08' %}
{%- if grains['oscodename'] == "focal" %}
{% set release = '20.04' %}
{% set hash = 'd02e79da976501dc665af07c53ad5501dc4ce0d606277bc5108456de3238c777' %}
include:
  - remnux.packages.libglib2
  - remnux.packages.qt5-default
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
      - sls: remnux.packages.qt5-default
      - sls: remnux.packages.libqt5scripttools5

{%- elif grains['oscodename'] == "bionic" %}

remnux-tools-detect-it-easy-source:
  test.nop

{%- endif %}
