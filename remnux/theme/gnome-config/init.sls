{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.config.user
  - remnux.theme.core.gnome-shell-extensions
  - remnux.theme.core.gnome-terminal
  - remnux.theme.core.gnome-tweaks

remnux-gnome-config-logo:
  file.managed:
    - name: /usr/local/share/remnux/remnux-logo.png
    - source: salt://remnux/theme/gnome-config/remnux-logo.png
    - makedirs: True

remnux-gnome-config-script:
  cmd.script:
      - name: /usr/local/share/remnux/gnome-config.sh
      - source: salt://remnux/theme/gnome-config/gnome-config.sh
      - mode: 755
      - makedirs: True
      - runas: {{ user }}
      - watch:
        - file: remnux-gnome-config-logo
      - require:
        - user: remnux-user-{{ user }}
        - sls: remnux.theme.core.gnome-shell-extensions

remnux-gnome-config-autostart-terminal:
  file.managed:
    - replace: False
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.config/autostart/gnome-terminal.desktop
    - source: salt://remnux/theme/gnome-config/gnome-terminal.desktop
    - makedirs: True
    - require:
      - sls: remnux.theme.core.gnome-terminal

remnux-gnome-config-autostart-ignore-lid-switch-tweak:
  file.managed:
    - replace: False
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.config/autostart/ignore-lid-switch-tweak.desktop
    - source: salt://remnux/theme/gnome-config/ignore-lid-switch-tweak.desktop
    - makedirs: True
    - require:
      - sls: remnux.theme.core.gnome-tweaks