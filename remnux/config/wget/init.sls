{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%} 

include:
  - remnux.packages.wget

remnux-config-wget:
  file.managed:
    - name: /home/{{ user }}/.wgetrc
    - source: salt://remnux/config/wget/wgetrc
    - makedirs: False
    - watch:
        - pkg: wget

remnux-config-wget-ownership:
  file.managed:
    - name: /home/{{ user }}/.wgetrc
    - user: {{ user }}
    - group: {{ user }}
    - watch:
        - file: remnux-config-wget
    - require:
      - sls: remnux.packages.wget


