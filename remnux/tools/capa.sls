# Name: capa
# Website: https://github.com/mandiant/capa
# Description: Detect suspicious capabilities in PE files.
# Category: Statically Analyze Code: PE Files
# Author: Mandiant, Willi Ballenthin: https://x.com/williballenthin, Moritz Raabe: https://x.com/m_r_tz
# License: Apache License 2.0: https://github.com/mandiant/capa/blob/master/LICENSE.txt
# Notes: 

{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}
  {% set file = 'capa-v9.3.1-linux-arm64' %}
  {% set hash = 'f4449f2f53d282feaf653d447bf760b316e41041e89f9c347e14b30d249f6f5d' %}
{% else %}
  {% set file = 'capa-v9.3.1-linux' %}
  {% set hash = '8338eab2eb647514bbd7a32104a102f5dc29580493b15b97b8b3503eae8d7966' %}
{% endif %}

remnux-tools-capa-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ file }}.zip
    - source: https://github.com/mandiant/capa/releases/download/v9.3.1/{{ file }}.zip
    - source_hash: {{ hash }}
    - makedirs: True

remnux-tools-capa-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/{{ file }}
    - source: /usr/local/src/remnux/files/{{ file }}.zip
    - enforce_toplevel: False
    - require:
      - file: remnux-tools-capa-source

remnux-tools-capa-binary:
  file.managed:
    - name: /usr/local/bin/capa
    - source: /usr/local/src/remnux/{{ file }}/capa
    - mode: 755
    - require:
      - archive: remnux-tools-capa-archive

remnux-tools-capa-cleanup1:
  file.absent:
    - name: /usr/local/share/capa-rules
    - require:
      - file: remnux-tools-capa-binary
