# Name: ProcmonMCP
# Command: procmon-mcp
# Website: https://github.com/JameZUK/ProcmonMCP
# Description: MCP server that lets AI assistants analyze Process Monitor (Procmon) XML captures.
# Category: Use Artificial Intelligence, Investigate System Interactions
# Author: James (JameZUK): https://x.com/JameZUK
# License: MIT License: https://github.com/JameZUK/ProcmonMCP/blob/procmon_parser/LICENSE
# Notes: Pre-configured for OpenCode as the "procmon" MCP server. On Windows, export the Procmon capture to XML (the native .PML format is not supported), copy the XML to REMnux, then ask the assistant to load it. Large captures with millions of events can take several minutes to load.

{% set commit = '78c151baa1c522999b3a37033200651ba8c3b353' %}
{% set hash = '4a4652d2f9eea80f93485b110b9164c0ac3c580517fe262cb17ce673ef73c690' %}
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

remnux-tools-procmon-mcp-extras:
  pip.installed:
    - pkgs:
      - psutil
    - bin_env: /opt/procmon-mcp-deps/bin/python3
    - require:
      - pip: remnux-tools-procmon-mcp-deps

remnux-tools-procmon-mcp-wrapper:
  file.managed:
    - name: /usr/local/bin/procmon-mcp
    - mode: 755
    - contents: |
        #!/bin/sh
        cd {{ srcdir }} && exec /opt/procmon-mcp-deps/bin/python3 -m procmon_mcp "$@"
    - require:
      - pip: remnux-tools-procmon-mcp-deps
      - pip: remnux-tools-procmon-mcp-extras
