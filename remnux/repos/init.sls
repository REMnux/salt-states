include:
  - remnux.repos.docker
  - remnux.repos.draios
  - remnux.repos.inetsim
  - remnux.repos.openjdk
  - remnux.repos.gift
  - remnux.repos.sift
  - remnux.repos.mono
  - remnux.repos.remnux
  - remnux.repos.wireshark-dev
  - remnux.repos.microsoft
  - remnux.repos.microsoft-vscode

remnux-repos:
  test.nop:
    - require:
      - sls: remnux.repos.docker
      - sls: remnux.repos.draios
      - sls: remnux.repos.inetsim
      - sls: remnux.repos.openjdk
      - sls: remnux.repos.gift
      - sls: remnux.repos.sift
      - sls: remnux.repos.mono
      - sls: remnux.repos.remnux
      - sls: remnux.repos.wireshark-dev
      - sls: remnux.repos.microsoft
      - sls: remnux.repos.microsoft-vscode