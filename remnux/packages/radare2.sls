# Name: radare2
# Website: https://www.radare.org/n/radare2.html
# Description: Examine binary files, including disassembling and debugging. Includes r2ai and decai plugins for LLM-powered analysis (API key or local Ollama required), plus the r2ghidra plugin for Ghidra decompilation via the pdg command.
# Category: Dynamically Reverse-Engineer Code: General, Use Artificial Intelligence, Statically Analyze Code: General
# Author: https://github.com/radareorg/radare2/blob/master/AUTHORS.md
# License: GNU Lesser General Public License (LGPL) v3: https://github.com/radareorg/radare2/blob/master/COPYING
# Notes: r2, rasm2, rabin2, rahash2, rafind2, r2ai, decai, pdg

{% from "remnux/osarch.sls" import osarch with context %}
{% set version = '6.1.8' %}
{% if osarch == "amd64" %}
  {% set hash = '91e64c672e65521758c0deb0f70d98ac90f0a78eb654d8bd0d894dd5735130e3' %}
  {% set dev_hash = '02aa819c187e835d0935a8c7d2586227f3defc01875915badc2df637418e70c1' %}
  {% set r2ghidra_hash = '81f2fd13b9bb60c34f5f03c963c8c03df68229f560dac0eec9720afdef325624' %}
{% elif osarch == "arm64" %}
  {% set hash = 'fc6717579be2ad2aaa5364aff8b134e9dd8fc0c1414a58c96659f413a2a2b750' %}
  {% set dev_hash = '8d120cd228284b998b64a18b9e35ab017f4a60824127036ac3860990aa36053c' %}
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
