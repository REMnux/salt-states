remnux-saltstack-key:
  file.managed:
    - name: /usr/share/keyrings/salt-archive-keyring.gpg
    - source: https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/3004/salt-archive-keyring.gpg
    - skip_verify: True
    - makedirs: True

saltstack-repo-cleanup:
  pkgrepo.absent:
    - name: deb [arch={{ grains['osarch'] }}] https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/3001 focal main
    - refresh: true

saltstack-repo-file-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/saltstack.list

saltstack-repo:
  pkgrepo.managed:
    - humanname: saltstack
    - name: deb [arch={{ grains['osarch'] }} signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/3004 focal main
    - file: /etc/apt/sources.list.d/saltstack.list
    - refresh: True
    - clean_file: True
    - require:
      - pkgrepo: saltstack-repo-cleanup
      - file: saltstack-repo-file-absent
      - file: remnux-saltstack-key
