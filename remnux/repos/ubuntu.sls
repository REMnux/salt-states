remnux-ubuntu-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - source: salt://remnux/repos/files/{{ grains['lsb_distrib_codename'] }}-ubuntu.sources
    - force: True
