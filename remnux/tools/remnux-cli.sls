{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.1.6/remnux-cli-linux" -%}		
{%- set hash = "ef887858f75e1f182406d520d7544f855b61dcf581979db441bc755cb35a6d4f" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755