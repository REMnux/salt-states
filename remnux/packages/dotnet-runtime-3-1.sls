# Name: .NET Runtime 3.1
# Website: https://dotnet.microsoft.com/
# Description: .NET runtime for running .NET applications that require version 3.1.
# Category: General Utilities
# Author: Microsoft
# License: MIT License: https://github.com/dotnet/runtime/blob/main/LICENSE.TXT
# Notes: Invoke using `dotnet3`. Downloaded manually because .NET 3.1 is not in Ubuntu Noble repos.

remnux-packages-dotnet-runtime-3-1-download:
  file.managed:
    - name: /usr/local/src/remnux/files/dotnet-runtime-3.1.32-linux-x64.tar.gz
    - source: https://builds.dotnet.microsoft.com/dotnet/Runtime/3.1.32/dotnet-runtime-3.1.32-linux-x64.tar.gz
    - source_hash: sha256=da49faf88c31aced91e341e3049de67f96d61891c28841511e7a26332f0bec88
    - makedirs: True

remnux-packages-dotnet-runtime-3-1-extract:
  archive.extracted:
    - name: /usr/local/dotnet/
    - source: /usr/local/src/remnux/files/dotnet-runtime-3.1.32-linux-x64.tar.gz
    - enforce_toplevel: False
    - watch:
      - file: remnux-packages-dotnet-runtime-3-1-download

remnux-packages-dotnet-runtime-3-1-permissions:
  file.managed:
    - name: /usr/local/dotnet/dotnet
    - mode: 755
    - require:
      - archive: remnux-packages-dotnet-runtime-3-1-extract

remnux-packages-dotnet-runtime-3-1-symlink:
  file.symlink:
    - name: /usr/local/bin/dotnet3
    - target: /usr/local/dotnet/dotnet
    - force: True
    - makedirs: False
    - require:
      - file: remnux-packages-dotnet-runtime-3-1-permissions
