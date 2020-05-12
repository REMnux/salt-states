{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user  %}
{% endif %}

include:
  - remnux.config.user

remnux-config-bash-rc:
  file.managed:
    - replace: False
    - name: {{ home }}/.bashrc
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: remnux-user-{{ user }}

remnux-config-bash-rc-aliases-file:
  file.managed:
    - replace: False
    - name: /usr/local/share/remnux/bash-aliases.sh
    - source: salt://remnux/config/bash-aliases.sh
    - makedirs: True

remnux-config-bash-rc-source-aliases:
  file.append:
    - name: {{ home }}/.bashrc
    - text: |
        if [ -f /usr/local/share/remnux/bash-aliases.sh ]; then
        . /usr/local/share/remnux/bash-aliases.sh
        fi
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - file: remnux-config-bash-rc
      - file: remnux-config-bash-rc-aliases-file