# Name: radare2
# Website: https://www.radare.org/n/radare2.html
# Description: Examine binary files, including disassembling and debugging. Includes r2ai and decai plugins for LLM-powered analysis (API key or local Ollama required), plus the r2ghidra plugin for Ghidra decompilation via the pdg command.
# Category: Dynamically Reverse-Engineer Code: General, Use Artificial Intelligence, Statically Analyze Code: General
# Author: https://github.com/radareorg/radare2/blob/master/AUTHORS.md
# License: GNU Lesser General Public License (LGPL) v3: https://github.com/radareorg/radare2/blob/master/COPYING
# Notes: r2, rasm2, rabin2, rahash2, rafind2, r2ai, decai, pdg

{% from "remnux/osarch.sls" import osarch with context %}
{% set version = '6.2.4' %}
{% if osarch == "amd64" %}
  {% set hash = '7019eedc0e0e87d1f53d6b8f5fc62b898567679c5efdce7fbfc557c9e7655e90' %}
  {% set dev_hash = 'cec4832762c4d0a029f78e724ce6a0d83cf8f04fe8ae5f69b50486983c08e347' %}
  {% set r2ghidra_hash = 'e5c184cc6943f5e99bcb1ecc2f3bdf200e58865eea01edfbfb787b0e476ea385' %}
{% elif osarch == "arm64" %}
  {% set hash = 'bbf48ee7bd5d8282f65a297dcabd34c9961a500e62d6b036679caab187b32ef1' %}
  {% set dev_hash = '09e4e50be48e3dc79b541a37f3bf1ee6ef21e33c5005b9cf232fa41952d74ade' %}
  {% set r2ghidra_hash = 'a8ac843c4e23e6cbf3c4e0975d84215f4706172109130fa0ee2229bc56faec26' %}
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
{% elif osarch == "arm64" %}
# r2ghidra publishes no arm64 .deb. Since 6.2.4, each release includes an
# r2pm binary bundle that upstream builds and tests on GitHub's arm64 runner.
# radare2-pm's r2ghidra recipe installs the same bundle. Extract it into a
# directory per version, then link its files where the amd64 .deb puts them,
# so radare2 loads the plugin for every user.
remnux-r2ghidra-source:
  file.managed:
    - name: /usr/local/src/r2ghidra-{{ version }}-linux-arm-64.zip
    - source: https://github.com/radareorg/r2ghidra/releases/download/{{ version }}/r2ghidra-{{ version }}-linux-arm-64.zip
    - source_hash: sha256={{ r2ghidra_hash }}
    - require:
      - pkg: remnux-radare2

remnux-r2ghidra-archive:
  archive.extracted:
    - name: /opt/r2ghidra/{{ version }}
    - source: /usr/local/src/r2ghidra-{{ version }}-linux-arm-64.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-r2ghidra-source

remnux-r2ghidra-plugin:
  file.symlink:
    - name: /usr/lib/radare2/{{ version }}/core_ghidra.so
    - target: /opt/r2ghidra/{{ version }}/plugins/core_ghidra.so
    - makedirs: True
    - force: True
    - require:
      - archive: remnux-r2ghidra-archive

remnux-r2ghidra-sleigh:
  file.symlink:
    - name: /usr/lib/radare2/{{ version }}/r2ghidra_sleigh
    - target: /opt/r2ghidra/{{ version }}/plugins/r2ghidra_sleigh
    - makedirs: True
    - force: True
    - require:
      - archive: remnux-r2ghidra-archive

{% for bin in ['sleighc', 'r2fidb'] %}
remnux-r2ghidra-{{ bin }}:
  file.symlink:
    - name: /usr/local/bin/{{ bin }}
    - target: /opt/r2ghidra/{{ version }}/bin/{{ bin }}
    - force: True
    - require:
      - archive: remnux-r2ghidra-archive
{% endfor %}
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
