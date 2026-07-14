# Name: js_unshroud
# Command: js_unshroud
# Website: https://github.com/edygert/js_unshroud
# Description: Monitor and deobfuscate JavaScript behavior in a headless browser to analyze malicious web pages.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Evan H. Dygert: https://www.linkedin.com/in/evandygert/
# License: MIT License: https://github.com/edygert/js_unshroud/blob/master/LICENSE.txt
# Notes: js_unshroud. Capture with `js_unshroud run --url <url> --out events.jsonl`; run it without arguments to see usage. Needs a display; on headless systems the wrapper starts a virtual one automatically (xvfb).

{% set version = '0.2.0' %}
{% set file = 'js_unshroud-linux-x64.tar.gz' %}
{% set hash = '1a63cdd7d1f107c3f01992bec41c439e19217f53b1c85c08bdb026de8f49ce60' %}

include:
  - remnux.packages.playwright

remnux-tools-js_unshroud-source:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ file }}
    - source: https://github.com/edygert/js_unshroud/releases/download/v{{ version }}/{{ file }}
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-tools-js_unshroud-archive:
  archive.extracted:
    - name: /opt/js_unshroud
    - source: /usr/local/src/remnux/files/{{ file }}
    - archive_format: tar
    - options: --strip-components=1
    - enforce_toplevel: False
    - force: True
    - require:
      - sls: remnux.packages.playwright
    - watch:
      - file: remnux-tools-js_unshroud-source

remnux-tools-js_unshroud-xvfb:
  pkg.installed:
    - name: xvfb

remnux-tools-js_unshroud-wrapper:
  file.managed:
    - name: /usr/local/bin/js_unshroud
    - mode: 755
    - contents: |
        #!/bin/bash
        export PLAYWRIGHT_BROWSERS_PATH=/opt/ms-playwright
        # The run subcommand launches a headed Playwright browser, which fails
        # without a display; start a virtual one when none is present.
        if [ "$1" = "run" ] && [ -z "$DISPLAY" ] && command -v xvfb-run >/dev/null 2>&1; then
          exec xvfb-run -a /opt/js_unshroud/js_unshroud-linux-x64 "$@"
        fi
        exec /opt/js_unshroud/js_unshroud-linux-x64 "$@"
    - require:
      - archive: remnux-tools-js_unshroud-archive
      - pkg: remnux-tools-js_unshroud-xvfb
