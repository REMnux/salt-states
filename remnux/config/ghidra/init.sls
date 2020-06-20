{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}

{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else %}
  {%- set home = "/home/" + user -%}
{%- endif -%}

include:
  - remnux.config.user
  - remnux.tools.ghidra

remnux-config-ghidra-gdt-file:
  file.managed:
    - name: /usr/local/src/remnux/files/ghidra-data-type.zip
    - source: https://raw.githubusercontent.com/REMnux/distro/master/files/ghidra-data-type.zip
    - source_hash: sha256=40d0d4595b8f0e6854d276a72cd0a9ce03f112a5512b28def5aefa8bbd795657
    - makedirs: true
    - require:
      - sls: remnux.tools.ghidra

remnux-config-ghidra-gdt-archive:
  archive.extracted:
    - name: {{ home }}/.ghidra/gdt
    - source: /usr/local/src/remnux/files/ghidra-data-type.zip
    - user: {{ user }}
    - group: {{ user }}
    - enforce_toplevel: False
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - file: remnux-config-ghidra-gdt-file

remnux-config-ghidra-file-preferences:
  file.managed:
    - name: {{ home }}/.ghidra/.ghidra_9.1.2_PUBLIC/preferences 
    - source: salt://remnux/config/ghidra/preferences
    - replace: False
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - archive: remnux-config-ghidra-gdt-archive

remnux-config-ghidra-file-tool-code-browser:
  file.managed:
    - name: {{ home }}/.ghidra/.ghidra_9.1.2_PUBLIC/tools/_code_browser.tcd
    - source: salt://remnux/config/ghidra/tool-code-browser.tcd
    - replace: False
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - sls: remnux.tools.ghidra

remnux-config-ghidra-file-tool-version-tracking:
  file.managed:
    - name: {{ home }}/.ghidra/.ghidra_9.1.2_PUBLIC/tools/_version _tracking.tcd
    - source: salt://remnux/config/ghidra/tool-version-tracking.tcd
    - replace: False
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - sls: remnux.tools.ghidra

remnux-config-ghidra-owner:
   file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.ghidra
    - makedirs: True
    - recurse:
      - user
      - group
    - watch:
      - sls: remnux.tools.ghidra

remnux-config-ghidra-icon:
  file.managed:
    - name: /usr/share/applications/ghidra.desktop
    - source: salt://remnux/config/ghidra/ghidra.desktop
    - replace: False
    - makedirs: True
    - watch:
      - sls: remnux.tools.ghidra