# Name: PowerShell Core
# Website: https://github.com/powershell/powershell
# Description: Run PowerShell scripts and commands.
# Category: Dynamically Reverse-Engineer Code: Scripts, General Utilities
# Author: Microsoft Corporation
# License: MIT License: https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt
# Notes: pwsh

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}
{# Microsoft's apt repository has no arm64 PowerShell package, so arm64 installs the release tarball. #}
{# Each version extracts to its own directory, because archive.extracted skips extraction when the files already exist. #}
{% set version = '7.6.6' %}
{% set hash = '924829e54c983648f6f1419a2dc7f9433c861b2fb5bd57736ff096c24f133729' %}

remnux-packages-powershell-deps:
  pkg.installed:
    - name: libicu74

remnux-packages-powershell-source:
  file.managed:
    - name: /usr/local/src/remnux/files/powershell-{{ version }}-linux-arm64.tar.gz
    - source: https://github.com/PowerShell/PowerShell/releases/download/v{{ version }}/powershell-{{ version }}-linux-arm64.tar.gz
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-packages-powershell-archive:
  archive.extracted:
    - name: /opt/microsoft/powershell/{{ version }}
    - source: /usr/local/src/remnux/files/powershell-{{ version }}-linux-arm64.tar.gz
    - enforce_toplevel: False
    - force: True
    - watch:
      - file: remnux-packages-powershell-source

remnux-packages-powershell-binary:
  file.managed:
    - name: /opt/microsoft/powershell/{{ version }}/pwsh
    - mode: 755
    - replace: False
    - require:
      - pkg: remnux-packages-powershell-deps
    - watch:
      - archive: remnux-packages-powershell-archive

remnux-packages-powershell-symlink:
  file.symlink:
    - name: /usr/local/bin/pwsh
    - target: /opt/microsoft/powershell/{{ version }}/pwsh
    - force: True
    - require:
      - file: remnux-packages-powershell-binary

{% else %}

include:
  - remnux.repos.microsoft

powershell:
  pkg.installed:
    - pkgrepo: microsoft

{% endif %}
