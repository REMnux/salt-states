remnux-mono-repo:
  pkgrepo.managed:
    - name: deb https://download.mono-project.com/repo/ubuntu stable-bionic main
    - dist: stable-bionic
    - file: /etc/apt/sources.list.d/mono-official-stable.list
    - keyid: D3D831EF
    - keyserver: keyserver.ubuntu.com
    - refresh: true

remnux-mono-install:
  pkg.installed:
    - fromrepo: stable-bionic
    - pkgs:
      - mono-devel
