remnux-repo:
  pkgrepo.managed:
    - ppa: remnux/stable
    - refresh: true
    # Source - https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xbff45016788de115
    - key_url: salt://remnux/repos/files/REMNUX-GPG-KEY.asc
    - gpgcheck: 1