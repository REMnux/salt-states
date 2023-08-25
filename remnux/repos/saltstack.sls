remnux-saltstack-key:
  file.managed:
    - name: /usr/share/keyrings/salt-archive-keyring-2023.gpg
    - source: https://repo.saltproject.io/salt/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/SALT-PROJECT-GPG-PUBKEY-2023.gpg
    - skip_verify: True
    - makedirs: True

saltstack-repo-cleanup1:
  pkgrepo.absent:
    - name: deb [arch={{ grains['osarch'] }}] https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/3001 focal main
    - refresh: true

saltstack-repo-cleanup2:
  pkgrepo.absent:
    - name: deb [arch={{ grains['osarch'] }}] https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/3004 focal main
    - refresh: true
    - require:
      - pkgrepo: saltstack-repo-cleanup1

saltstack-repo-file-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/saltstack.list

saltstack-repo:
  pkgrepo.managed:
    - humanname: saltstack
    - name: deb [signed-by=/usr/share/keyrings/salt-archive-keyring-2023.gpg arch={{ grains['osarch'] }}] https://repo.saltproject.io/salt/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/3006 focal main
    - file: /etc/apt/sources.list.d/saltstack.list
    - refresh: True
    - clean_file: True
    - require:
      - pkgrepo: saltstack-repo-cleanup2
      - file: saltstack-repo-file-absent
      - file: remnux-saltstack-key
