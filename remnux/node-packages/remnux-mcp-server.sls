# Name: REMnux MCP Server
# Website: https://github.com/REMnux/remnux-mcp-server
# Description: MCP server for using the REMnux malware analysis toolkit via AI assistants.
# Category: Use Artificial Intelligence
# Author: Lenny Zeltser
# License: GPL-3.0: https://github.com/REMnux/remnux-mcp-server/blob/main/LICENSE
# Notes: remnux-mcp-server

include:
  - remnux.packages.nodejs

remnux-node-packages-remnux-mcp-server:
  npm.installed:
    - name: "@remnux/mcp-server"
    - force_reinstall: true
    - require:
      - sls: remnux.packages.nodejs
