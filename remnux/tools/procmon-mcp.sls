# Name: ProcmonMCP
# Command: procmon-mcp
# Website: https://github.com/JameZUK/ProcmonMCP
# Description: MCP server that lets AI assistants analyze Process Monitor (Procmon) XML captures.
# Category: Use Artificial Intelligence, Investigate System Interactions
# Author: James (JameZUK): https://github.com/JameZUK
# License: MIT
# Notes: Pre-configured for OpenCode as the "procmon" MCP server. On Windows, export the Procmon capture to XML (the native .PML format is not supported), copy the XML to REMnux, then ask the assistant to load it. Large captures with millions of events can take several minutes to load.

{% set commit = '68be9668c31b17d8db3bc4314ddd11bf57345702' %}
{% set hash = '350a310b4f21395ccb27c1f602e77eb75f543c8b19d0589e7364788787ec3dbf' %}
{% set srcdir = '/opt/ProcmonMCP-' + commit %}

include:
  - remnux.packages.python3-virtualenv

remnux-tools-procmon-mcp-source:
  file.managed:
    - name: /usr/local/src/remnux/files/procmon-mcp-{{ commit }}.tar.gz
    - source: https://github.com/JameZUK/ProcmonMCP/archive/{{ commit }}.tar.gz
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-tools-procmon-mcp-archive:
  archive.extracted:
    - name: /opt
    - source: /usr/local/src/remnux/files/procmon-mcp-{{ commit }}.tar.gz
    - if_missing: {{ srcdir }}
    - keep_source: True
    - require:
      - file: remnux-tools-procmon-mcp-source

remnux-tools-procmon-mcp-patch:
  file.replace:
    - name: {{ srcdir }}/procmon_mcp/server.py
    - pattern: '\bdescription\s*='
    - repl: 'instructions='
    - backup: False
    - require:
      - archive: remnux-tools-procmon-mcp-archive

remnux-tools-procmon-mcp-venv:
  virtualenv.managed:
    - name: /opt/procmon-mcp-deps
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-tools-procmon-mcp-deps:
  pip.installed:
    - requirements: {{ srcdir }}/requirements.txt
    - bin_env: /opt/procmon-mcp-deps/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-tools-procmon-mcp-venv
      - archive: remnux-tools-procmon-mcp-archive

remnux-tools-procmon-mcp-wrapper:
  file.managed:
    - name: /usr/local/bin/procmon-mcp
    - mode: 755
    - contents: |
        #!/bin/sh
        cd {{ srcdir }} && exec /opt/procmon-mcp-deps/bin/python3 -m procmon_mcp "$@"
    - require:
      - pip: remnux-tools-procmon-mcp-deps
      - file: remnux-tools-procmon-mcp-patch
