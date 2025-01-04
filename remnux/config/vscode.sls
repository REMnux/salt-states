{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

{% set settings_path = home + '/.config/Code/User/settings.json' %}

include:
  - remnux.config.user
  - remnux.packages.vscode

remnux-config-vscode-dir:
  file.directory:
    - name: {{ home }}/.config/Code/User
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
        - sls: remnux.packages.vscode

remnux-config-vscode-settings:
  file.managed:
    - name: {{ settings_path }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
    - replace: False
    - makedirs: True
    - contents: |
        {
            "workbench.startupEditor": "none"
        }
    - unless: >
        test -f {{ settings_path }} &&
        grep -q "workbench.startupEditor" {{ settings_path }}
    - require:
      - file: remnux-config-vscode-dir