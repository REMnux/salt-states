include:
  - remnux.packages.software-properties-common

remnux-repos-dotnet-backports:
  pkgrepo.managed:
    - name: dotnet-backports
    - ppa: dotnet/backports
    - keyid: 45A3F127159BE9E5017811C62125B164E8E5D3FA
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: remnux.packages.software-properties-common
