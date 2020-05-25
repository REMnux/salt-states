{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}

{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else %}
  {%- set home = "/home/" + user -%}
{%- endif -%}

include:
  - remnux.config.user
  - remnux.tools.ghidra

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
      - sls: remnux.tools.ghidra

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

remnux-config-ghidra-icon:
  file.managed:
    - name: /usr/share/applications/ghidra.desktop
    - source: salt://remnux/config/ghidra/ghidra.desktop
    - replace: False
    - makedirs: True
    - watch:
      - sls: remnux.tools.ghidra