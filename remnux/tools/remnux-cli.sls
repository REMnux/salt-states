{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.2.1/remnux-cli-linux" -%}		
{%- set hash = "61b30e75a45123f3e46825452e9d15810b7852a9e59bea50c253a34180a7b4a5" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755