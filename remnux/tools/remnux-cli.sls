{%- set source = "https://github.com/REMnux/remnux-cli/releases/download/v1.1.5/remnux-cli-linux" -%}		
{%- set hash = "eea66d6bbda1954a990bc79e03c94093b680938290eb90165f290dedc2baa895" -%}		

remnux-tool-remnux-cli:
  file.managed:
    - name: /usr/local/bin/remnux
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755