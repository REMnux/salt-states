{% from "remnux/osarch.sls" import osarch with context %}
remnux-saltstack-key:
  file.managed:
    - name: /usr/share/keyrings/salt-archive-keyring.pgp
    - source: https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public
    - skip_verify: True
    - makedirs: True

saltstack-repo-cleanup1:
  pkgrepo.absent:
    - name: deb [arch={{ osarch }}] https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ osarch }}/3001 focal main
    - refresh: true

saltstack-repo-cleanup2:
  pkgrepo.absent:
    - name: deb [arch={{ osarch }}] https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ osarch }}/3004 focal main
    - refresh: true
    - require:
      - pkgrepo: saltstack-repo-cleanup1

saltstack-repo-cleanup3:
  pkgrepo.absent:
    - name: deb [arch={{ osarch }}] https://repo.saltproject.io/py3/ubuntu/{{ grains['lsb_distrib_release'] }}/{{ osarch }}/3006 focal main
    - refresh: true
    - require:
      - pkgrepo: saltstack-repo-cleanup1

saltstack-repo-file-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/saltstack.list

saltstack-repo-pin-version-3006:
  file.managed:
    - name: /etc/apt/preferences.d/salt-pin-1001
    - mode: 755
    - watch:
      - file: saltstack-repo-file-absent
    - contents:
      - 'Package: salt-*'
      - 'Pin: version 3006.*'
      - 'Pin-Priority: 1001'

saltstack-repo:
  pkgrepo.managed:
    - humanname: saltstack
    - name: deb [signed-by=/usr/share/keyrings/salt-archive-keyring.pgp arch={{ osarch }}] https://packages.broadcom.com/artifactory/saltproject-deb/ stable main
    - file: /etc/apt/sources.list.d/saltstack.list
    - refresh: True
    - clean_file: True
    - require:
      - pkgrepo: saltstack-repo-cleanup2
      - pkgrepo: saltstack-repo-cleanup3
      - file: saltstack-repo-file-absent
      - file: remnux-saltstack-key
      - file: saltstack-repo-pin-version-3006
