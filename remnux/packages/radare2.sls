# Name: radare2
# Website: https://www.radare.org/n/radare2.html
# Description: Examine binary files, including disassembling and debugging. Includes r2ai and decai plugins for LLM-powered analysis (API key or local Ollama required).
# Category: Dynamically Reverse-Engineer Code: General
# Author: https://github.com/radareorg/radare2/blob/master/AUTHORS.md
# License: GNU Lesser General Public License (LGPL) v3: https://github.com/radareorg/radare2/blob/master/COPYING
# Notes: r2, rasm2, rabin2, rahash2, rafind2, r2ai, decai

{% from "remnux/osarch.sls" import osarch with context %}
{% set version = '6.0.8' %}
{% if osarch == "amd64" %}
  {% set hash = '9ddc1bc21835dd184e652583b6ea3aee29e7eae028aaa4f3415900c77a5addc3' %}
  {% set dev_hash = '3ca8a9640e3c98a26ebd83e4be65c297b8e8a6f5d38acb4bfa4ac73a0d34c654' %}
{% elif osarch == "arm64" %}
  {% set hash = '27ea795a20b66cf6d0b0e911b3770bf96df6110dc1e4548d28f1d19d77b7624f' %}
  {% set dev_hash = 'e18b844ae4aabba000a20eefdb058a367082bfb32d2e56786925e93a2652eb9d' %}
{% endif %}
{% set user = salt['pillar.get']('remnux_user', 'remnux') %}
{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}
{% set installed_version = salt['cmd.shell']("dpkg -l | grep radare2 | awk '{print $3}'") %}

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
    - unless: test -f {{ home }}/.local/share/radare2/plugins/r2ai.so
    - require:
      - file: remnux-radare2-dev-source

remnux-radare2-r2ai-install:
  cmd.run:
    - name: r2pm -ci r2ai && r2pm -ci decai
    - runas: {{ user }}
    - cwd: {{ home }}
    - env:
      - HOME: {{ home }}
    - unless: test -f {{ home }}/.local/share/radare2/plugins/r2ai.so
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
