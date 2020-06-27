microsoft-vscode:
  pkgrepo.managed:
    - humanname: Microsoft Visual Studio Code
    - name: deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main
    - file: /etc/apt/sources.list.d/microsoft-vscode.list
    - key_url: https://packages.microsoft.com/keys/microsoft.asc
    - refresh: true