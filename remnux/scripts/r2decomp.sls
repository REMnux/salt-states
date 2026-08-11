# Name: r2decomp
# Website: https://github.com/lennyzeltser/r2decomp
# Description: Decompile the function behind a capa match using radare2 and the Ghidra decompiler.
# Category: Statically Analyze Code: General
# Author: Lenny Zeltser: https://x.com/lennyzeltser
# License: MIT: https://github.com/lennyzeltser/r2decomp/blob/master/LICENSE
# Notes: Pairs with capa. Run "r2decomp doctor" to confirm radare2 and the r2ghidra pdg decompiler are present.

# Upstream publishes no tags or releases, so the source is pinned to a commit
# rather than to master: a push upstream would otherwise fail the source_hash
# check on every clean install until this file caught up.
#
# Installed on every architecture even though remnux.packages.radare2 ships the
# r2ghidra deb on amd64 only. r2pm works on arm64, so "r2pm -ci r2ghidra" is a
# working fix there, and it is exactly what "r2decomp doctor" prints. That is a
# better arm64 experience than the tool being absent.

{% set commit = '771df8326aa1ad123eef9f56b81ec5f00663defa' %}
{% set hash = '7b0416e709077e7b527f382999eeaa4311a0c16bf5f458c5119c3689c751afed' %}

include:
  - remnux.packages.python3
  - remnux.packages.radare2

remnux-scripts-r2decomp:
  file.managed:
    - name: /usr/local/bin/r2decomp
    - source: https://github.com/lennyzeltser/r2decomp/raw/{{ commit }}/r2decomp.py
    - source_hash: sha256={{ hash }}
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.python3
      - sls: remnux.packages.radare2
