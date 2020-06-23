{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}

{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else %}
  {%- set home = "/home/" + user -%}
{%- endif -%}

include:
  - remnux.config.user
  - remnux.theme.core.gnome-shell-extensions
  - remnux.theme.core.gnome-terminal
  - remnux.theme.core.gnome-tweaks
  - remnux.tools.cutter
  - remnux.tools.binnavi
  - remnux.tools.cyberchef
  - remnux.tools.networkminer
  - remnux.theme.gnome-config.remove-app-icons

remnux-gnome-config-logo:
  file.managed:
    - name: /usr/local/share/remnux/remnux-logo.png
    - source: salt://remnux/theme/gnome-config/remnux-logo.png
    - makedirs: True

remnux-gnome-config-script:
  file.managed:
      - name: /usr/local/share/remnux/gnome-config.sh
      - source: salt://remnux/theme/gnome-config/gnome-config.sh
      - mode: 755
      - makedirs: True
      - watch:
        - file: remnux-gnome-config-logo
      - require:
        - sls: remnux.theme.core.gnome-shell-extensions

remnux-gnome-config-dconf-directory:
  file.directory:
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.config/dconf
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - file: remnux-gnome-config-script

remnux-gnome-config-script-run:
  cmd.run:
    - name: dbus-run-session -- /usr/local/share/remnux/gnome-config.sh
    - cwd: {{ home }}
    - shell: /bin/bash
    - runas: {{ user }}
    - watch:
        - file: remnux-gnome-config-dconf-directory
    - require:
      - user: remnux-user-{{ user }}

remnux-gnome-config-autostart-terminal:
  file.managed:
    - replace: False
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.config/autostart/gnome-terminal.desktop
    - source: salt://remnux/theme/gnome-config/gnome-terminal.desktop
    - makedirs: True
    - require:
      - user: remnux-user-{{ user }}
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

# Allow root to run X commands
remnux-gnome-config-autostart-xhost:
  file.managed:
    - replace: False
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.config/autostart/xhost.desktop
    - source: salt://remnux/theme/gnome-config/xhost.desktop
    - makedirs: True
    - require:
      - sls: remnux.theme.core.gnome-tweaks

remnux-gnome-config-autostart-parent-owner:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - name: {{ home }}/.config
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - file: remnux-gnome-config-autostart-xhost

remnux-gnome-config-terminal-profiles-file:
  file.managed:
    - name: /usr/local/share/remnux/terminal-profiles.ini
    - source: salt://remnux/theme/gnome-config/terminal-profiles.ini
    - user: root
    - group: root
    - mode: 0644
    - makedirs: True
    - require:
      - sls: remnux.theme.core.gnome-terminal

remnux-gnome-config-terminal-profiles-install:
  cmd.run:
    - name: dbus-run-session -- dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < /usr/local/share/remnux/terminal-profiles.ini
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - file: remnux-gnome-config-terminal-profiles-file

remnux-gnome-config-keyring-ssh-disable-autostart:
  file.replace:
    - name: /etc/xdg/autostart/gnome-keyring-ssh.desktop
    - pattern: 'X-GNOME-Autostart-enabled=false'
    - repl: 'X-GNOME-Autostart-enabled=false'
    - append_if_not_found: True
    - count: 1

remnux-gnome-config-cutter-icon:
  file.managed:
    - replace: False
    - name: /usr/share/applications/cutter.desktop
    - source: salt://remnux/theme/gnome-config/cutter.desktop
    - makedirs: True
    - require:
      - sls: remnux.tools.cutter

remnux-gnome-config-binnavi-icon-file:
  file.managed:
    - replace: False
    - name: /usr/share/icons/binnavi.png
    - source: salt://remnux/theme/gnome-config/binnavi.png
    - makedirs: True
    - require:
      - sls: remnux.tools.binnavi

remnux-gnome-config-binnavi-icon:
  file.managed:
    - replace: False
    - name: /usr/share/applications/binnavi.desktop
    - source: salt://remnux/theme/gnome-config/binnavi.desktop
    - makedirs: True
    - watch:
      - file: remnux-gnome-config-binnavi-icon-file

remnux-gnome-config-cyberchef-icon-file:
  file.managed:
    - replace: False
    - name: /usr/share/icons/cyberchef.png
    - source: salt://remnux/theme/gnome-config/cyberchef.png
    - makedirs: True
    - require:
      - sls: remnux.tools.cyberchef

remnux-gnome-config-networkminer-icon-file:
  file.managed:
    - replace: False
    - name: /usr/share/icons/networkminer.png
    - source: salt://remnux/theme/gnome-config/networkminer.png
    - makedirs: True
    - require:
      - sls: remnux.tools.networkminer

remnux-gnome-config-networkminer-icon:
  file.managed:
    - replace: False
    - name: /usr/share/applications/networkminer.desktop
    - source: salt://remnux/theme/gnome-config/networkminer.desktop
    - makedirs: True
    - watch:
      - file: remnux-gnome-config-networkminer-icon-file

remnux-gnome-config-cyberchef-icon:
  file.managed:
    - replace: False
    - name: /usr/share/applications/cyberchef.desktop
    - source: salt://remnux/theme/gnome-config/cyberchef.desktop
    - makedirs: True
    - watch:
      - file: remnux-gnome-config-cyberchef-icon-file

remnux-theme-gnome-config:
  test.nop:
    - require:
      - sls: remnux.theme.gnome-config.remove-app-icons