{% from "remnux/osarch.sls" import osarch with context %}
remnux-microsoft-vscode-key:
  file.managed:
    - name: /usr/share/keyrings/MICROSOFT.asc
    - source: https://packages.microsoft.com/keys/microsoft.asc
    - skip_verify: True
    - makedirs: True

remnux-microsoft-vscode-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/microsoft-vscode.list

remnux-microsoft-vscode-sources-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/microsoft-vscode.sources

remnux-microsoft-vscode-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/vscode.sources
    - contents: |
        Types: deb
        URIs: https://packages.microsoft.com/repos/code
        Suites: stable
        Components: main
        Signed-By: /usr/share/keyrings/MICROSOFT.asc
        Architectures: {{ osarch }}
    - require:
      - file: remnux-microsoft-vscode-key
      - file: remnux-microsoft-vscode-list-absent
      - file: remnux-microsoft-vscode-sources-absent
