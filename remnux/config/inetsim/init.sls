include:
  - remnux.packages.inetsim

remnux-config-inetsim:
  file.managed:
    - name: /etc/inetsim/inetsim.conf
    - source: salt://remnux/config/inetsim/inetsim.conf
    - user: root
    - group: root
    - makedirs: True
    - require:
      - sls: remnux.packages.inetsim

