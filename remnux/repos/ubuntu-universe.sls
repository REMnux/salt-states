remnux-universe-repo:
  file.replace:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - pattern: '^(Components: )(?!.*\buniverse\b)(.*)$'
    - repl: '\1\2 universe'
    - flags:
        - MULTILINE
