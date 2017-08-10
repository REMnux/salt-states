draios:
  pkgrepo.managed:
    - humanname: Draios
    - name: deb http://download.draios.com/stable/deb stable-{{ grains['osarch'] }}/
    - file: /etc/apt/sources.list.d/draios.list
    # Source - https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public
    - key_url: salt://remnux/repos/files/DRAIOS-GPG-KEY.asc
    - gpgcheck: 1
    - refresh_db: true
