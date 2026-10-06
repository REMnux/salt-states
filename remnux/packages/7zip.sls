# Name: 7-Zip
# Website: https://www.7-zip.org
# Description: Compress and decompress files using a variety of algorithms.
# Category: General Utilities, Examine Static Properties: General
# Author: Igor Pavlov
# License: GNU Lesser General Public License (LGPL)
# Notes: 7-Zip standard: 7z, 7za, 7zr. For latest alpha version, use 7zz instead of 7z.

{% from "remnux/osarch.sls" import osarch with context %}

include:
  - remnux.repos.remnux

remnux-packages-p7zip-full:
  pkg.installed:
    - name: p7zip-full

{% if osarch == "arm64" %}
{# The REMnux PPA builds 7zz for amd64 only, so arm64 installs 7-Zip's own arm64 build #}
{% set file = '7z2501-linux-arm64' %}
{% set hash = '39c5140f02ce4436599303c59a149f654cb1bbc47cdc105a942120d747ae040d' %}

remnux-packages-7zz-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ file }}.tar.xz
    - source: https://github.com/ip7z/7zip/releases/download/25.01/{{ file }}.tar.xz
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-packages-7zz-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/{{ file }}
    - source: /usr/local/src/remnux/files/{{ file }}.tar.xz
    - enforce_toplevel: False
    - watch:
      - file: remnux-packages-7zz-source

remnux-packages-7zz:
  file.managed:
    - name: /usr/local/bin/7zz
    - source: /usr/local/src/remnux/{{ file }}/7zz
    - mode: 755
    - watch:
      - archive: remnux-packages-7zz-archive

{% else %}

remnux-packages-7zz:
  pkg.installed:
    - name: 7zz
    - version: latest
    - upgrade: True
    - pkgrepo: remnux

{% endif %}
