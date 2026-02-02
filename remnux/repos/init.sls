include:
  - remnux.repos.ubuntu-universe
  - remnux.repos.docker
  - remnux.repos.openjdk
  - remnux.repos.gift
  - remnux.repos.sift
  - remnux.repos.mono
  - remnux.repos.remnux
  - remnux.repos.wireshark-dev
  - remnux.repos.microsoft
  - remnux.repos.microsoft-vscode
  - remnux.repos.nodejs
  - remnux.repos.winehq
  - remnux.repos.refresh

remnux-repos:
  test.nop:
    - require:
      - sls: remnux.repos.ubuntu-universe
      - sls: remnux.repos.docker
      - sls: remnux.repos.openjdk
      - sls: remnux.repos.gift
      - sls: remnux.repos.sift
      - sls: remnux.repos.mono
      - sls: remnux.repos.remnux
      - sls: remnux.repos.wireshark-dev
      - sls: remnux.repos.microsoft
      - sls: remnux.repos.microsoft-vscode
      - sls: remnux.repos.nodejs
      - sls: remnux.repos.winehq
      - sls: remnux.repos.refresh
