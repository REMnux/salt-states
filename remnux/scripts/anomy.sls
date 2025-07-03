# Name: Anomy
# Website: https://github.com/izm1chael/Anomy
# Description: A wrapper around wget, ssh, sftp, ftp, and telnet to route these connections through Tor to anonymize your traffic.
# Category: Explore Network Interactions: Connecting
# Author: Mike Johnson: https://cyber-bytes.co.uk
# License: Free, unknown license
# Notes: anomy

{% set hash = 'e31ada5e8cf6048c1068512432111a244768d3474e1c1bd02201193be6342e90' %}

include:
  - remnux.packages.tor
  - remnux.packages.sudo
  - remnux.packages.wget
  - remnux.packages.openssh

remnux-scripts-anomy-source:
  file.managed:
    - name: /usr/local/bin/anomy
    - source: https://github.com/izm1chael/Anomy/raw/main/anomy.sh
    - source_hash: sha256={{ hash }}
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.tor
      - sls: remnux.packages.sudo
      - sls: remnux.packages.wget
      - sls: remnux.packages.openssh

remnux-scripts-anomy-user-agent:
  file.replace:
    - name: /usr/local/bin/anomy
    - pattern: '\-U "Mozilla\/4\.0 \(compatible; MSIE 8\.0; Windows NT 5\.1; Trident\/4\.0; GTB6; \.NET CLR 1\.1\.4322\)" '
    - repl: ''
    - backup: false
    - prepend_if_not_found: False
    - count: 1
    - require:
      - file: remnux-scripts-anomy-source
