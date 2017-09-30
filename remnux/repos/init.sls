include:
  - remnux.repos.docker
  - remnux.repos.draios
  - remnux.repos.inetsim
  - remnux.repos.openjdk
  - remnux.repos.gift
  - remnux.repos.sift

remnux-repos:
  test.nop:
    - require:
      - sls: remnux.repos.docker
      - sls: remnux.repos.draios
      - sls: remnux.repos.inetsim
      - sls: remnux.repos.openjdk
      - sls: remnux.repos.gift
      - sls: remnux.repos.sift
      
