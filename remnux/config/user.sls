{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}
{%- set all_users = salt['user.list_users']() -%}

{%- if user in all_users -%}

remnux-user-{{ user }}:
  user.present:
    - name: {{ user }}

{%- else %}

remnux-user-{{ user }}:
  group.present:
    - name: {{ user }}
  user.present:
    - name: {{ user }}
    - gid: {{ user }}
    - fullname: REMnux User
    - shell: /bin/bash
    - home: /home/{{ user }}
    - password: $6$7n5jpcUZ$oh6U9W9mWKbtgIcY8y4buQZR3XMBOU2xUi4xGH9kvcB9o4IIsFLZ/.ffhqqVI0gkVchcJf3RSLxQhpgwXgmBR/

{%- endif %}
