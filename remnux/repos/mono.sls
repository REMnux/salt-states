mono-repo:
  pkgrepo.managed:
    - humanname: Mono
    - name: deb https://download.mono-project.com/repo/ubuntu stable-bionic main
    - file: /etc/apt/sources.list.d/mono-official-stable.list
    - keyid: D3D831EF
    - keyserver: keyserver.ubuntu.com
    - gpgcheck: 1
    - refresh: true
