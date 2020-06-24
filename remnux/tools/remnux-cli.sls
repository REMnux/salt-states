{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.2.2/remnux-cli-linux" -%}		
{%- set hash = "5e743df8450f1324a613fdbdde6e47941f7cb0f58c1294c1ab0d6d1f2ec46a16" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755