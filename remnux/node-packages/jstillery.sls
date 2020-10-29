# Name: JStillery
# Website: https://github.com/mindedsecurity/jstillery
# Description: Deobfuscate JavaScript scripts using AST and Partial Evaluation techniques.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Stefano Di Paola, Minded Security: http://www.mindedsecurity.com
# License: GNU General Public License (GPL) v3: https://github.com/mindedsecurity/JStillery/blob/master/LICENSE
# Notes:jstillery

include:
  - remnux.packages.nodejs
  - remnux.packages.git

remnux-node-packages-jstillery:
  npm.installed:
    - name: git+https://github.com/mindedsecurity/JStillery.git
    - force_reinstall: true
    - require:
      - sls: remnux.packages.nodejs
      - sls: remnux.packages.git

remnux-node-packages-jstillery-symlink:
  file.symlink:
    - name: /usr/bin/jstillery
    - target: /usr/lib/node_modules/JStillery_Server/jstillery_cli.js
    - mode: 755
    - require:
      - npm: remnux-node-packages-jstillery