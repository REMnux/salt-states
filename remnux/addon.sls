# Install the REMnux foundation. This is appropriate for adding REMnux to an existing 
# system and doesn't modify the user's existing user interface or other aspects of 
# the environment that the user likely wants to keep intact.

include:
  - remnux.network
  - remnux.repos
  - remnux.python3-packages
  - remnux.packages
  - remnux.rubygems
  - remnux.scripts
  - remnux.config
  - remnux.tools
  - remnux.node-packages
  - remnux.perl-packages
  - remnux.tools.remnux-installer

remnux-addon-version-file:
  file.managed:
    - name: /etc/remnux-version
    - source: salt://remnux/VERSION
    - user: root
    - group: root
    - require:
      - sls: remnux.network
      - sls: remnux.repos
      - sls: remnux.python3-packages
      - sls: remnux.packages
      - sls: remnux.rubygems
      - sls: remnux.scripts
      - sls: remnux.config
      - sls: remnux.tools
      - sls: remnux.node-packages
      - sls: remnux.perl-packages
      - sls: remnux.tools.remnux-installer
