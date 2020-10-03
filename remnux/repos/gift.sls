gift-repo:
  pkgrepo.managed:
    - ppa: gift/stable
    - refresh: true
    # Source - https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3ED1EAECE81894B171D7DA5B5E80511B10C598B8
    - key_url: salt://remnux/repos/files/GIFT-GPG-KEY.asc
    - gpgcheck: 1