{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.2.3/remnux-cli-linux" -%}		
{%- set hash = "7c5657e03224abfea1c5571b1d3995ef6e3ce74892dc908e721bb6adabdb496f" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755