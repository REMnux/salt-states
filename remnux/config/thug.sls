{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.config.user
  - remnux.config.bash-rc
  - remnux.config.bash-aliases
  - remnux.python-packages.thug

remnux-config-thug:
  file.directory:
    - name: /var/log/thug
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - user: remnux-user-{{ user }}
    - require:
      - sls: remnux.python-packages.thug

remnux-config-thug-bash-rc:
  file.append:
    - name: {{ home }}/.bashrc
    - text: 'export THUG_LOGBASE=/var/log/thug'
    - require:
      - user: remnux-user-{{ user }}
    - watch:
       - file: remnux-config-bash-rc
       - file: remnux-config-thug
       - file: remnux-config-bash-aliases
