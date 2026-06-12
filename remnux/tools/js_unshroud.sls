# Name: js_unshroud
# Website: https://github.com/edygert/js_unshroud
# Description: Monitor and deobfuscate JavaScript behavior in a headless browser to analyze malicious web pages.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Evan H. Dygert
# License: MIT License: https://github.com/edygert/js_unshroud/blob/master/LICENSE.txt
# Notes: js_unshroud. Capture with `js_unshroud run --url <url> --out events.jsonl`; run it without arguments to see usage. Needs a display (use `xvfb-run` if headless).

{% set version = '0.1.0' %}
{% set hash = 'f792d9329c466590ab50cd9c289ade2fc4a11d3ab20d699b1c6e3a5211a96f13' %}

include:
  - remnux.packages.playwright

remnux-tools-js_unshroud-binary:
  file.managed:
    - name: /opt/js_unshroud/js_unshroud
    - source: https://github.com/edygert/js_unshroud/releases/download/v{{ version }}/js_unshroud-linux-x64
    - source_hash: sha256={{ hash }}
    - mode: 755
    - makedirs: True
    - require:
      - sls: remnux.packages.playwright

remnux-tools-js_unshroud-wrapper:
  file.managed:
    - name: /usr/local/bin/js_unshroud
    - mode: 755
    - contents: |
        #!/bin/bash
        export PLAYWRIGHT_BROWSERS_PATH=/opt/ms-playwright
        exec /opt/js_unshroud/js_unshroud "$@"
    - require:
      - file: remnux-tools-js_unshroud-binary
