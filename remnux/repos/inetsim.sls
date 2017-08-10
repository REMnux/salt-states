inetsim-repo:
  pkgrepo.managed:
    - humanname: InetSim
    - name: deb http://www.inetsim.org/debian/ binary/
    - file: /etc/apt/sources.list.d/inetsim.list
    # Source - http://www.inetsim.org/inetsim-archive-signing-key.asc
    - key_url: salt://remnux/repos/files/INETSIM-GPG-KEY.asc
    - gpgcheck: 1
    - refresh_db: true
