# Name: Bytehist
# Website: https://www.cert.at/downloads/software/bytehist_en.html
# Description: Generate byte-usage-histograms for all types of files with a focus PE files.
# Category: Statically Analyze Code: Unpacking
# Author: Christian Wojner: https://twitter.com/Didelphodon
# License: ISC License: https://en.wikipedia.org/wiki/ISC_license
# Notes: bytehist

remnux-tools-bytehist-source:
  file.managed:
    - name: /usr/local/src/remnux/files/bytehist_1_0_102_linux.zip
    - source: https://www.cert.at/media/files/downloads/software/bytehist/files/bytehist_1_0_102_linux.zip
    - source_hash: 74f3fe50a1fe53d9b1b030eadf53a0faaea4f171b60e68713655d77e49b04b20
    - makedirs: True

remnux-tools-bytehist-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/bytehist_1_0_102_linux
    - source: /usr/local/src/remnux/files/bytehist_1_0_102_linux.zip
    - enforce_toplevel: False
    - watch:
      - file: remnux-tools-bytehist-source

remnux-tools-bytehist-binary:
  file.managed:
    - name: /usr/local/bin/bytehist
    - source: /usr/local/src/remnux/bytehist_1_0_102_linux/lin64/bytehist
    - mode: 755
    - watch:
      - archive: remnux-tools-bytehist-archive