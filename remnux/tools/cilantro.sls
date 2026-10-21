# Name: CILantro
# Website: https://github.com/jgajek/cilantro
# Description: Deobfuscate and unpack .NET programs protected with .NET Reactor, ConfuserEx, Babel .NET, or Dotfuscator, without running them.
# Category: Statically Analyze Code: .NET, Statically Analyze Code: Unpacking
# Author: Jacob Gajek: https://github.com/jgajek
# License: MIT License: https://github.com/jgajek/cilantro/blob/main/LICENSE
# Architecture: amd64
# Arm64: Use ILSpy to decompile .NET programs, though it doesn't deobfuscate them.
# Notes: cilantro

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-tools-cilantro-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: CILantro is not available for this architecture."

{% else %}

{% set version = '1.0.5' %}
{% set file = 'cilantro-linux-x64-' ~ version ~ '.tar.gz' %}
{% set hash = '00f87c1f494112d6dab11b564bcd27264629fbdd6232d66cbe37be067a6ba9a1' %}

remnux-tools-cilantro-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ file }}
    - source: https://github.com/jgajek/cilantro/releases/download/v{{ version }}/cilantro-linux-x64.tar.gz
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

{% endif %}
