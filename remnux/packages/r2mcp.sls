# Name: r2mcp
# Website: https://github.com/radareorg/radare2-mcp
# Description: Model Context Protocol server that lets AI agents drive radare2 to open binaries, analyze code, decompile functions, and find vulnerabilities. Pre-configured for OpenCode as the radare2 MCP server (amd64 only).
# Category: Use Artificial Intelligence
# Author: pancake: https://github.com/radareorg/radare2-mcp
# License: MIT: https://github.com/radareorg/radare2-mcp/blob/main/LICENSE
# Notes: r2mcp, r2mcp-svc

{% from "remnux/osarch.sls" import osarch with context %}
{% set version = '1.8.4' %}
{% if osarch == "amd64" %}
  {% set hash = 'ccd87b6a53a6110dc4cbbdbdca90810e97757c2172c0ee9dfb98473c9cd5d494' %}
{% endif %}

include:
  - remnux.packages.radare2

{% if osarch == "amd64" %}
remnux-r2mcp-source:
  file.managed:
    - name: /usr/local/src/r2mcp_{{ version }}_{{ osarch }}.deb
    - source: https://github.com/radareorg/radare2-mcp/releases/download/{{ version }}/r2mcp_{{ version }}_{{ osarch }}.deb
    - source_hash: sha256={{ hash }}
    - require:
      - sls: remnux.packages.radare2

remnux-r2mcp:
  pkg.installed:
    - sources:
      - r2mcp: /usr/local/src/r2mcp_{{ version }}_{{ osarch }}.deb
    - watch:
      - file: remnux-r2mcp-source
    - require:
      - sls: remnux.packages.radare2
{% endif %}
