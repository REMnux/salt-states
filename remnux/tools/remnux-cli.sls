{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.1.7/remnux-cli-linux" -%}		
{%- set hash = "05dae35991e451f47103239a0d2376d6d456529b75ede48055fe6afc85549fd6" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755