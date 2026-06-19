{% from "remnux/osarch.sls" import osarch with context %}
{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.config.user
  - remnux.node-packages.opencode
  - remnux.node-packages.remnux-mcp-server
  - remnux.tools.ghidrassist-mcp
{% if osarch == "amd64" %}
  - remnux.packages.r2mcp
{% endif %}

remnux-config-opencode-dir:
  file.directory:
    - name: {{ home }}/.config/opencode
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - sls: remnux.node-packages.opencode

remnux-config-opencode-settings:
  file.serialize:
    - name: {{ home }}/.config/opencode/config.json
    - dataset:
        mcp:
          remnux:
            type: local
            command:
              - remnux-mcp-server
            enabled: true
          remnux-docs:
            type: remote
            url: https://docs.remnux.org/~gitbook/mcp
            enabled: true
          ghidra:
            type: remote
            url: http://localhost:8080/mcp
            enabled: true
{% if osarch == "amd64" %}
          radare2:
            type: local
            command:
              - r2mcp
            enabled: true
{% endif %}
    - formatter: json
    - merge_if_exists: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
    - require:
      - file: remnux-config-opencode-dir
      - sls: remnux.node-packages.remnux-mcp-server
      - sls: remnux.tools.ghidrassist-mcp
{% if osarch == "amd64" %}
      - sls: remnux.packages.r2mcp
{% endif %}
