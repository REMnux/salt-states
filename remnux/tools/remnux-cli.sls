{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.2.5/remnux-cli-linux" -%}		
{%- set hash = "dc79a10e31eb795dfe749f35c45b1570033676f1a3df4882917ae24c807cdd5e" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755