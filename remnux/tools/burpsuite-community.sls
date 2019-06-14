# Source: https://portswigger.net/burp/communitydownload
# License: https://portswigger.net/burp/eula/community

include:
  - remnux.packages.default-jre

remnux-tools-burpsuite-community:
  file.managed:
    - name: /usr/local/burpsuite-community/burpsuite_community.jar
    - source: https://portswigger.net/burp/releases/download?product=community&version=1.7.36&type=jar
    - source_hash: sha256=2a9437a29f3e0429571ae21a1856d20bec729131cd934abac909354f8075a48a
    - makedirs: True
    - require:
      - sls: remnux.packages.default-jre


remnux-tools-burpsuite-community-wrapper:
  file.managed:
    - name: /usr/local/bin/burpsuite
    - mode: 755
    - watch:
        - file: remnux-tools-burpsuite-community
    - contents:
        #!/bin/bash
        java -jar /usr/local/burpsuite-community/burpsuite_community.jar ${*}
