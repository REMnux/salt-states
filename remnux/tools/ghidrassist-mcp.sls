# Name: GhidrAssistMCP
# Website: https://github.com/jtang613/GhidrAssistMCP
# Description: MCP server for AI-assisted reverse engineering in Ghidra.
# Category: Use Artificial Intelligence
# Author: Jason Tang: https://www.linkedin.com/in/jason-tang-174652157/
# License: MIT: https://github.com/jtang613/GhidrAssistMCP/blob/master/LICENSE
# Notes: After installation, enable the plugin in Ghidra: File → Configure → Miscellaneous → GhidrAssistMCPPlugin. Then start the MCP server: Window → GhidrAssistMCP. The server listens on port 8080. OpenCode is pre-configured to connect at http://localhost:8080/mcp.

include:
  - remnux.packages.ghidra

remnux-tools-ghidrassist-mcp-source:
  file.managed:
    - name: /usr/local/src/remnux/files/ghidra_12.0_PUBLIC_20260123_GhidrAssistMCP.zip
    - source: https://github.com/jtang613/GhidrAssistMCP/releases/download/2.0.0/ghidra_12.0_PUBLIC_20260123_GhidrAssistMCP.zip
    - source_hash: sha256=4db06971d63201b17cb6f12124d8eaace3c20ceef6c45b58b64ca0e7fd3a59e1
    - makedirs: True
    - require:
      - sls: remnux.packages.ghidra

remnux-tools-ghidrassist-mcp-archive:
  archive.extracted:
    - name: /opt/ghidra/Ghidra/Extensions/
    - source: /usr/local/src/remnux/files/ghidra_12.0_PUBLIC_20260123_GhidrAssistMCP.zip
    - enforce_toplevel: True
    - watch:
      - file: remnux-tools-ghidrassist-mcp-source
