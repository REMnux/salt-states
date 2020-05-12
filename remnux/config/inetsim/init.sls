{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.config.user
  - remnux.config.bash-rc
  - remnux.packages.inetsim

remnux-config-inetsim:
  file.managed:
    - name: /etc/inetsim/inetsim.conf
    - source: salt://remnux/config/inetsim/inetsim.conf
    - user: root
    - group: root
    - makedirs: True
    - require:
      - sls: remnux.packages.inetsim

emnux-config-inetsim-function:
  file.append:
    - name: {{ home }}/.bashrc
    - text: |
      function inetsim {
        sudo fuser -k -n tcp 80
        sudo inetsim --bind-address=${1:-`myip`}
      }
    - require:
      - user: remnux-user-{{ user }}
    - watch:
       - file: remnux-config-bash-rc
       - file: remnux-config-inetsim