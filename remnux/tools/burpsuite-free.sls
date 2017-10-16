# Source: https://portswigger.net/burp/freedownload
# License: https://portswigger.net/burp/eula/free

include:
  - remnux.packages.default-jre

remnux-tools-burpsuite-free:
  file.managed:
    - name: /usr/local/burpsuite-free/burpsuite_free.jar
    - source: https://portswigger.net/burp/releases/download?product=free&version=1.7.27&type=jar
    - skip_verify: True
    - makedirs: True
    - require:
      - sls: remnux.packages.default-jre


remnux-tools-burpsuite-free-wrapper:
  file.managed:
    - name: /usr/local/bin/burpsuite
    - mode: 755
    - watch:
        - file: remnux-tools-burpsuite-free
    - contents:
        #!/bin/bash
        java -jar /usr/local/burpsuite-free/burpsuite_free.jar ${*}
