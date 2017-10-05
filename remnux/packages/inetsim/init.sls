# Source: http://www.inetsim.org/
# Authors: Thomas Hungenberg and Matthias Eckert

include:
  - remnux.repos.inetsim

inetsim:
  pkg.installed:
    - pkgrepo: inetsim-repo

remnux-config-inetsim-config:
  file.managed:
    - name: /etc/inetsim/inetsim.conf
    - source: salt://remnux/packages/inetsim/inetsim.conf
    - user: root
    - group: root
    - makedirs: True

