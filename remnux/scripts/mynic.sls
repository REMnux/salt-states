include:
  - remnux.packages.iproute2

remnux-scripts-mynic-source:
  file.managed:
    - name: /usr/local/bin/mynic
    - source: https://raw.githubusercontent.com/REMnux/distro/master/files/mynic
    - source_hash: sha256=266a86fd0b75307e4cb36ec8936a9c87653498787d10438571f63efc37b2b5c2
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.iproute2