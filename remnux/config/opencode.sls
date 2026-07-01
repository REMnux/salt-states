{% set user = salt['pillar.get']('remnux_user', 'remnux') %}

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.config.user
  - remnux.node-packages.opencode
  - remnux.node-packages.remnux-mcp-server
  - remnux.tools.ghidrassist-mcp
  - remnux.tools.procmon-mcp
  - remnux.tools.x64dbg-automate-mcp

# OpenCode needs a clipboard helper to read/write the system clipboard on Linux.
# REMnux defaults to GNOME-on-Wayland, so wl-clipboard (wl-copy/wl-paste) is the
# backend opencode auto-detects; without it, "Copied to clipboard" silently no-ops.
remnux-config-opencode-clipboard:
  pkg.installed:
    - name: wl-clipboard

remnux-config-opencode-dir:
  file.directory:
    - name: {{ home }}/.config/opencode
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - sls: remnux.node-packages.opencode

remnux-config-opencode-settings:
  file.serialize:
    - name: {{ home }}/.config/opencode/config.json
    - dataset:
        mcp:
          remnux:
            type: local
            command:
              - remnux-mcp-server
            enabled: true
          remnux-docs:
            type: remote
            url: https://docs.remnux.org/~gitbook/mcp
            enabled: true
          ghidra:
            type: remote
            url: http://localhost:8080/mcp
            enabled: true
          procmon:
            type: local
            command:
              - procmon-mcp
            enabled: true
          x64dbg:
            type: local
            command:
              - x64dbg-automate-mcp
            enabled: false
    - formatter: json
    - merge_if_exists: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
    - require:
      - file: remnux-config-opencode-dir
      - sls: remnux.node-packages.remnux-mcp-server
      - sls: remnux.tools.ghidrassist-mcp
      - sls: remnux.tools.procmon-mcp
      - sls: remnux.tools.x64dbg-automate-mcp

# Ship the finish-reason plugin to every user so OpenCode surfaces abnormal LLM
# stop reasons (content-filter, length, error, ...) and session errors on a
# 60-second TUI toast plus a log entry under service=finish-reason-plugin in
# ~/.local/share/opencode/log/. Normal "stop"/"tool-calls" turns stay silent.
# The plugin's only import is `import type`, erased at load, so it needs no deps.
remnux-config-opencode-plugins-dir:
  file.directory:
    - name: {{ home }}/.config/opencode/plugins
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - file: remnux-config-opencode-dir

remnux-config-opencode-finish-reason-plugin:
  file.managed:
    - name: {{ home }}/.config/opencode/plugins/finish-reason.ts
    - source: salt://remnux/config/opencode-finish-reason.ts
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
    - require:
      - file: remnux-config-opencode-plugins-dir

# OpenCode custom commands for the x64dbg skills. The command files ship inside the
# x64dbg-skills-opencode repo (laid down at /opt/x64dbg-skills-opencode by the
# x64dbg-automate-mcp state) and are copied into the user's OpenCode commands dir.
# The copy runs only when the source archive changes, so it refreshes on version bumps.
remnux-config-opencode-x64dbg-commands-dir:
  file.directory:
    - name: {{ home }}/.config/opencode/commands
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - file: remnux-config-opencode-dir

remnux-config-opencode-x64dbg-commands:
  cmd.run:
    - name: |
        for f in /opt/x64dbg-skills-opencode/commands/x64dbg-*.md; do
          install -o {{ user }} -g {{ user }} -m 644 "$f" {{ home }}/.config/opencode/commands/
        done
    - onchanges:
      - archive: remnux-tools-x64dbg-automate-mcp-archive
    - require:
      - file: remnux-config-opencode-x64dbg-commands-dir
