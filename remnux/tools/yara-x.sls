# Name: YARA-X
# Website: https://github.com/VirusTotal/yara-x
# Description: Scan files using YARA rules, the next generation of YARA written in Rust.
# Category: Gather and Analyze Data
# Author: Victor M. Alvarez, VirusTotal: https://github.com/VirusTotal
# License: BSD-3-Clause License: https://github.com/VirusTotal/yara-x/blob/main/LICENSE
# Notes: yr scan, yr compile. Coexists with classic YARA; uses `yr` command.

remnux-tools-yara-x-source:
  file.managed:
    - name: /usr/local/src/remnux/files/yara-x-v1.13.0-x86_64-unknown-linux-gnu.gz
    - source: https://github.com/VirusTotal/yara-x/releases/download/v1.13.0/yara-x-v1.13.0-x86_64-unknown-linux-gnu.gz
    - source_hash: b93fb0b87016c60498c26b8a17d2617bbc49f5d5b1a291cde5b09658ce93bb69
    - makedirs: True

remnux-tools-yara-x-archive:
  archive.extracted:
    - name: /usr/local/src/remnux/yara-x-v1.13.0
    - source: /usr/local/src/remnux/files/yara-x-v1.13.0-x86_64-unknown-linux-gnu.gz
    - archive_format: tar
    - enforce_toplevel: False
    - require:
      - file: remnux-tools-yara-x-source

remnux-tools-yara-x-binary:
  file.managed:
    - name: /usr/local/bin/yr
    - source: /usr/local/src/remnux/yara-x-v1.13.0/yr
    - mode: 755
    - require:
      - archive: remnux-tools-yara-x-archive
