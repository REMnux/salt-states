{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.1.4/remnux-cli-linux" -%}		
{%- set hash = "270f839bc0b9ad76d7226366b0ecb7f37092b7021f4654953d3e12d3d263df2f" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755