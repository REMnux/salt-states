include:
  - remnux.repos.ubuntu-universal
  - remunx.repos.docker
  - remunx.repos.draios
  - remunx.repos.inetsim
  - remunx.repos.sift
  - remunx.repos.remnux

remnux-repos:
  test.nop:
    - require:
      - sls: remnux.repos.ubuntu-universal
      - sls: remunx.repos.docker
      - sls: remunx.repos.draios
      - sls: remunx.repos.inetsim
      - sls: remunx.repos.sift
      - sls: remunx.repos.remnux
      
