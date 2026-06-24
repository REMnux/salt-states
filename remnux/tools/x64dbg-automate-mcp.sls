# Name: x64dbg Automate MCP (OpenCode skills)
# Command: x64dbg-automate-mcp
# Website: https://github.com/REMnux/x64dbg-skills-opencode
# Description: Drive x64dbg on a remote Windows VM from OpenCode on REMnux, with eight AI commands for tracing, unpacking, state snapshots, decompiling, YARA scanning, and vulnerability hunting.
# Category: Use Artificial Intelligence, Dynamically Reverse-Engineer Code: General
# Author: Darius Houle: https://github.com/dariushoule
# License: MIT License: https://github.com/REMnux/x64dbg-skills-opencode/blob/main/LICENSE
# Notes: Ships disabled by default in OpenCode. It only works once x64dbg runs with the x64dbg-automate plugin in Remote mode on a separate Windows VM and you connect to it from OpenCode. The eight commands are /x64dbg-tracealyzer, /x64dbg-find-oep, /x64dbg-shellcode-analyzer, /x64dbg-state-snapshot, /x64dbg-state-diff, /x64dbg-decompile, /x64dbg-yara-sigs, and /x64dbg-vuln-hunter. Forked from dariushoule/x64dbg-skills (a Claude Code plugin) and adapted for OpenCode on REMnux.

{% set commit = '7c21f5fcfe774c26c9b0a7dab1bb5a0e761f51f0' %}
{% set hash = '5027c4fc1cf30b114d65ceb8bad6bc29efa6f6e32fa84a7cbd178394a3457726' %}
{% set src = '/opt/x64dbg-skills-opencode' %}
{% set venv = '/opt/x64dbg-automate-mcp-deps' %}

include:
  - remnux.packages.python3-virtualenv

remnux-tools-x64dbg-automate-mcp-source:
  file.managed:
    - name: /usr/local/src/remnux/files/x64dbg-skills-opencode-{{ commit }}.tar.gz
    - source: https://github.com/REMnux/x64dbg-skills-opencode/archive/{{ commit }}.tar.gz
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-tools-x64dbg-automate-mcp-archive:
  archive.extracted:
    - name: {{ src }}
    - source: /usr/local/src/remnux/files/x64dbg-skills-opencode-{{ commit }}.tar.gz
    - options: --strip-components=1
    - enforce_toplevel: False
    - force: True
    - watch:
      - file: remnux-tools-x64dbg-automate-mcp-source

remnux-tools-x64dbg-automate-mcp-venv:
  virtualenv.managed:
    - name: {{ venv }}
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-tools-x64dbg-automate-mcp-deps:
  pip.installed:
    - pkgs:
      - x64dbg_automate[mcp]
      - angr[unicorn]
      - yara-python
      - lief
    - bin_env: {{ venv }}/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-tools-x64dbg-automate-mcp-venv

remnux-tools-x64dbg-automate-mcp-wrapper:
  file.managed:
    - name: /usr/local/bin/x64dbg-automate-mcp
    - mode: 755
    - contents: |
        #!/bin/sh
        exec {{ venv }}/bin/x64dbg-automate-mcp "$@"
    - require:
      - pip: remnux-tools-x64dbg-automate-mcp-deps

remnux-tools-x64dbg-automate-mcp-yarasigs:
  git.latest:
    - name: https://github.com/x64dbg/yarasigs.git
    - target: {{ src }}/yarasigs
    - submodules: True
    - require:
      - archive: remnux-tools-x64dbg-automate-mcp-archive
