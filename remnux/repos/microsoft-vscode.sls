{% from "remnux/osarch.sls" import osarch with context %}
remnux-microsoft-vscode-key:
  file.managed:
    - name: /usr/share/keyrings/MICROSOFT.asc
    - source: https://packages.microsoft.com/keys/microsoft.asc
    - skip_verify: True
    - makedirs: True

microsoft-vscode:
  pkgrepo.managed:
    - humanname: Microsoft Visual Studio Code
    - name: deb [arch={{ osarch }} signed-by=/usr/share/keyrings/MICROSOFT.asc] https://packages.microsoft.com/repos/vscode stable main
    - file: /etc/apt/sources.list.d/vscode.list
    - refresh: True
    - clean_file: True
    - require:
      - file: remnux-microsoft-vscode-key
