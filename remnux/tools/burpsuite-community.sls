# Name: Burp Suite Community Edition
# Website: https://portswigger.net
# Description: Investigate website interactions using a web proxy
# Category: Script Analysis and Deobfuscation
# Author: PortSwigger
# License: https://portswigger.net/burp/tc-community
# Notes: burpsuite

include:
  - remnux.packages.default-jre

remnux-tools-burpsuite-community:
  file.managed:
    - name: /usr/local/burpsuite-community/burpsuite_community.jar
    - source: https://portswigger.net/burp/releases/download?product=community&version=2020.2.1&type=jar
    - source_hash: sha256=d60aae76f65bbea92775fff73a35ee395841ee817d7f7eff281970d79270d622
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
