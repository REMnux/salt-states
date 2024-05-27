{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

include:
  - remnux.config.user
  - remnux.tools.networkminer

remnux-config-rename-networkminer-assembledfiles:
  file.rename:
    - name: /usr/local/NetworkMiner_2-9/AssembledFiles.original
    - source: /usr/local/NetworkMiner_2-9/AssembledFiles
    - force: true
    - makedirs: True
    - require:
      - sls: remnux.tools.networkminer
  
remnux-config-create-networkminer-assembledfiles:
  file.directory:
    - name: /var/log/networkminer/AssembledFiles/cache
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - file: remnux-config-rename-networkminer-assembledfiles

remnux-config-networkminer-assembledfiles-link:
  file.symlink:
    - name: /usr/local/NetworkMiner_2-9/AssembledFiles
    - target: /var/log/networkminer/AssembledFiles
    - watch:
      - file: remnux-config-create-networkminer-assembledfiles

remnux-config-rename-networkminer-captures:
  file.rename:
    - name: /usr/local/NetworkMiner_2-9/Captures.original
    - source: /usr/local/NetworkMiner_2-9/Captures
    - force: true
    - makedirs: True
    - require:
      - sls: remnux.tools.networkminer
  
remnux-config-create-networkminer-captures:
  file.directory:
    - name: /var/log/networkminer/Captures
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - user: remnux-user-{{ user }}
    - watch:
      - file: remnux-config-rename-networkminer-captures

remnux-config-networkminer-captures-link:
  file.symlink:
    - name: /usr/local/NetworkMiner_2-9/Captures
    - target: /var/log/networkminer/Captures
    - watch:
      - file: remnux-config-create-networkminer-captures
