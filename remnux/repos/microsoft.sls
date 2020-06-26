microsoft:
  pkgrepo.managed:
    - humanname: Microsoft
    - name: deb [arch=amd64] https://packages.microsoft.com/ubuntu/{{ grains['lsb_distrib_release'] }}/prod {{ grains['lsb_distrib_codename'] }} main
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/microsoft.list
    - key_url: https://packages.microsoft.com/keys/microsoft.asc
    - refresh: true