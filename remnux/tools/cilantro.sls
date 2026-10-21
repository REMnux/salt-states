# Name: CILantro
# Website: https://github.com/jgajek/cilantro
# Description: Deobfuscate and unpack .NET programs protected with .NET Reactor, ConfuserEx, Babel .NET, or Dotfuscator, without running them.
# Category: Statically Analyze Code: .NET, Statically Analyze Code: Unpacking
# Author: Jacob Gajek: https://x.com/jgajek
# License: MIT License: https://github.com/jgajek/cilantro/blob/main/LICENSE
# Notes: cilantro

{% from "remnux/osarch.sls" import osarch with context %}

{% set version = '1.0.6' %}
{% if osarch == "arm64" %}
{% set arch = 'arm64' %}
{% set hash = 'b09e4402d805ce45e5e995ab17a6c70f0c2b40467bf20346f7fd4b5c89d400af' %}
{% else %}
{% set arch = 'x64' %}
{% set hash = '9fd5dbf80e18305f105f85d55ed90dab4644390110a503ec32a938e482c7ec7f' %}
{% endif %}
{% set file = 'cilantro-linux-' ~ arch ~ '-' ~ version ~ '.tar.gz' %}

remnux-tools-cilantro-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ file }}
    - source: https://github.com/jgajek/cilantro/releases/download/v{{ version }}/cilantro-linux-{{ arch }}.tar.gz
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-tools-cilantro-archive:
  archive.extracted:
    - name: /opt/cilantro
    - source: /usr/local/src/remnux/files/{{ file }}
    - source_hash: sha256={{ hash }}
    - source_hash_update: True
    - enforce_toplevel: False
    - user: root
    - group: root
    - watch:
      - file: remnux-tools-cilantro-source

remnux-tools-cilantro-binary:
  file.symlink:
    - name: /usr/local/bin/cilantro
    - target: /opt/cilantro/cilantro
    - force: True
    - require:
      - archive: remnux-tools-cilantro-archive
