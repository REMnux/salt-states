{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.2.4/remnux-cli-linux" -%}		
{%- set hash = "19a1cc45cd1481d53087addee15cfe0fc386564af2d74705cea834dab0f99df8" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755