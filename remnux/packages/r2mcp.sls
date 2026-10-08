# Name: r2mcp
# Website: https://github.com/radareorg/radare2-mcp
# Description: Model Context Protocol server that lets AI agents drive radare2 to open binaries, analyze code, decompile functions, and find vulnerabilities. Pre-configured for OpenCode as the radare2 MCP server.
# Category: Use Artificial Intelligence
# Author: pancake: https://github.com/radareorg/radare2-mcp
# License: MIT: https://github.com/radareorg/radare2-mcp/blob/main/LICENSE
# Architecture: amd64
# Arm64: No alternative identified.
# Notes: r2mcp, r2mcp-svc

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-r2mcp-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: r2mcp is not available for this architecture."

{% else %}
{% set version = '1.8.8' %}
{% set hash = '1de404fd88881fd2a543c6c4e552a688f2120966c809da4bbfec9594ec669000' %}

include:
  - remnux.packages.radare2

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
