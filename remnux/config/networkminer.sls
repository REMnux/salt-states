{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

include:
  - remnux.config.user
  - remnux.tools.networkminer

# If this is already a symlink, leave it alone. Otherwise, we run into errors in some cases.
{% if 0 != salt['cmd.retcode']('test -L /usr/local/NetworkMiner_2-5/AssembledFiles') %}

remnux-config-networkminer-assembledfiles:
  file.rename:
    - name: /var/log/networkminer/AssembledFiles
    - source: /usr/local/NetworkMiner_2-5/AssembledFiles
    - force: true
    - makedirs: True
    - require:
      - user: remnux-user-{{ user }}
      - sls: remnux.tools.networkminer
  
remnux-config-networkminer-assembledfiles-permissions:
  file.directory:
    - name: /var/log/networkminer/AssembledFiles
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - file: remnux-config-networkminer-assembledfiles

remnux-config-networkminer-assembledfiles-link:
  file.symlink:
    - name: /usr/local/NetworkMiner_2-5/AssembledFiles
    - target: /var/log/networkminer/AssembledFiles
    - watch:
      - file: remnux-config-networkminer-assembledfiles-permissions

{% endif %}

# If this is already a symlink, leave it alone. Otherwise, we run into errors in some cases.
{% if 0 != salt['cmd.retcode']('test -L /usr/local/NetworkMiner_2-5/Captures') %}

remnux-config-networkminer-captures:
  file.rename:
    - name: /var/log/networkminer/Captures
    - source: /usr/local/NetworkMiner_2-5/Captures
    - force: true
    - makedirs: True
    - require:
      - user: remnux-user-{{ user }}
  
remnux-config-networkminer-captures-permissions:
  file.directory:
    - name: /var/log/networkminer/Captures
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - file: remnux-config-networkminer-captures

remnux-config-networkminer-captures-link:
  file.symlink:
    - name: /usr/local/NetworkMiner_2-5/Captures
    - target: /var/log/networkminer/Captures
    - watch:
      - file: remnux-config-networkminer-captures-permissions

{% endif %}