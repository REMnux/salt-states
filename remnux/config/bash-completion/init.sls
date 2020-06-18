include:
  - remnux.scripts.pdf-parser

remnux-config-bash-completion-pdf-parser:
  file.managed:
    - name: /etc/bash_completion.d/pdf-parser
    - source: salt://remnux/config/bash-completion/pdf-parser
    - replace: False
    - makedirs: True
    - mode: 644
    - require:
        - sls: remnux.scripts.pdf-parser