# Name: radare2
# Website: https://www.radare.org/n/radare2.html
# Description: Examine binary files, including disassembling and debugging. Includes r2ai and decai plugins for LLM-powered analysis (API key or local Ollama required), plus the r2ghidra plugin for Ghidra decompilation via the pdg command.
# Category: Dynamically Reverse-Engineer Code: General, Use Artificial Intelligence, Statically Analyze Code: General
# Author: https://github.com/radareorg/radare2/blob/master/AUTHORS.md
# License: GNU Lesser General Public License (LGPL) v3: https://github.com/radareorg/radare2/blob/master/COPYING
# Notes: r2, rasm2, rabin2, rahash2, rafind2, r2ai, decai, pdg

{% from "remnux/osarch.sls" import osarch with context %}
{% set version = '6.1.6' %}
{% if osarch == "amd64" %}
  {% set hash = '5c8798a1b9d974c4730031abac3e9c7ee033270fca9c6d87a6a5eb7b36bc0f75' %}
  {% set dev_hash = '66202c62f0f601be812f738efdee482b8a7809924ba84e5c2bdd28b9ca77134c' %}
  {% set r2ghidra_hash = '4a30f0c378ce84dbcee8d998ee39d7bb455d6fe0a243022b8164855ccb3f7d79' %}
{% elif osarch == "arm64" %}
  {% set hash = '57f8428a9f40488b821238aea5295b754a928aba8f343c2026454f92131ce2da' %}
  {% set dev_hash = 'ef28bfbd1c8e229b91cd0a48bda37bcee72b58edd8a85cf8e6135b1124b7d072' %}
{% endif %}
{% set user = salt['pillar.get']('remnux_user', 'remnux') %}
{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}
{% set installed_version = salt['cmd.shell']("dpkg-query -W -f='${Version}' radare2 2>/dev/null || true") %}

include:
  - remnux.packages.git
  - remnux.packages.build-essential
  - remnux.packages.pkg-config
  - remnux.packages.curl
  - remnux.config.user

{% if installed_version != '' and installed_version > version %}
Installed Version {{ installed_version }} is higher than intended version:
  test.nop
{% else %}

remnux-radare2-source:
  file.managed:
    - name: /usr/local/src/radare2_{{ version }}_{{ osarch }}.deb
    - source: https://github.com/radareorg/radare2/releases/download/{{ version }}/radare2_{{ version }}_{{ osarch }}.deb
    - source_hash: sha256={{ hash }}

remnux-radare2:
  pkg.installed:
    - sources:
      - radare2: /usr/local/src/radare2_{{ version }}_{{ osarch }}.deb
    - watch:
      - file: remnux-radare2-source
    - require:
      - pkg: git

remnux-radare2-cleanup:
  pkg.removed:
    - name: libradare2-common
    - require:
      - pkg: remnux-radare2

{% if osarch == "amd64" %}
remnux-r2ghidra-source:
  file.managed:
    - name: /usr/local/src/r2ghidra_{{ version }}_{{ osarch }}.deb
    - source: https://github.com/radareorg/r2ghidra/releases/download/{{ version }}/r2ghidra_{{ version }}_{{ osarch }}.deb
    - source_hash: sha256={{ r2ghidra_hash }}
    - require:
      - pkg: remnux-radare2

remnux-r2ghidra:
  pkg.installed:
    - sources:
      - r2ghidra: /usr/local/src/r2ghidra_{{ version }}_{{ osarch }}.deb
    - watch:
      - file: remnux-r2ghidra-source
    - require:
      - pkg: remnux-radare2
{% endif %}

remnux-radare2-r2pm-update:
  cmd.run:
    - name: r2pm -U
    - runas: {{ user }}
    - cwd: {{ home }}
    - env:
      - HOME: {{ home }}
    - unless: test -d {{ home }}/.local/share/radare2/r2pm/git/radare2-pm
    - require:
      - pkg: remnux-radare2-cleanup
      - user: remnux-user-{{ user }}

remnux-radare2-dev-source:
  file.managed:
    - name: /usr/local/src/radare2-dev_{{ version }}_{{ osarch }}.deb
    - source: https://github.com/radareorg/radare2/releases/download/{{ version }}/radare2-dev_{{ version }}_{{ osarch }}.deb
    - source_hash: sha256={{ dev_hash }}
    - require:
      - cmd: remnux-radare2-r2pm-update

remnux-radare2-dev-install:
  cmd.run:
    - name: dpkg -i /usr/local/src/radare2-dev_{{ version }}_{{ osarch }}.deb
    - unless: test "$(cat {{ home }}/.local/share/radare2/plugins/.r2ai-radare2-version 2>/dev/null)" = "{{ version }}"
    - require:
      - file: remnux-radare2-dev-source

remnux-radare2-r2ai-install:
  cmd.run:
    - name: r2pm -ci r2ai && r2pm -ci decai && mkdir -p {{ home }}/.local/share/radare2/plugins && echo '{{ version }}' > {{ home }}/.local/share/radare2/plugins/.r2ai-radare2-version
    - runas: {{ user }}
    - cwd: {{ home }}
    - env:
      - HOME: {{ home }}
    - unless: test "$(cat {{ home }}/.local/share/radare2/plugins/.r2ai-radare2-version 2>/dev/null)" = "{{ version }}"
    - require:
      - cmd: remnux-radare2-dev-install
      - pkg: build-essential
      - pkg: pkg-config
      - sls: remnux.packages.curl
      - user: remnux-user-{{ user }}

remnux-radare2-dev-cleanup:
  cmd.run:
    - name: dpkg -r radare2-dev
    - onlyif: dpkg -l radare2-dev 2>/dev/null | grep -q ^ii
    - require:
      - cmd: remnux-radare2-r2ai-install

remnux-radare2-plugin-ownership:
  file.directory:
    - name: {{ home }}/.local/share/radare2
    - user: {{ user }}
    - group: {{ user }}
    - recurse:
      - user
      - group
    - require:
      - cmd: remnux-radare2-dev-cleanup

{% endif %}
