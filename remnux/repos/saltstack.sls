
saltstack-repo-cleanup:
  pkgrepo.absent:
    - name: deb [arch={{ grains['osarch'] }}] https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/3001 focal main
    - refresh: true

saltstack-repo:
  pkgrepo.managed:
    - humanname: saltstack
    - name: deb [arch={{ grains['osarch'] }}] https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/3004 focal main
    - file: /etc/apt/sources.list.d/saltstack.list
    - key_url: https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ grains['osarch'] }}/3004/salt-archive-keyring.gpg
    - gpgcheck: 1
    - refresh: true
    - require:
      - pkgrepo: saltstack-repo-cleanup