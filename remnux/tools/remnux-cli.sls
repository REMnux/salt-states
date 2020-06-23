{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.2.0/remnux-cli-linux" -%}		
{%- set hash = "387886796021642f4a735baaf1fe29926094f7359bb58539a2f1520ee1d45734" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755