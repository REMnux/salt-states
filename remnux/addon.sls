# Install the REMnux foundation. This is appropriate for adding REMnux to an existing 
# system and doesn't modify the user's existing user interface or other aspects of 
# the environment that the user likely wants to keep intact.

include:
  - remnux.repos
  - remnux.packages
  - remnux.python-packages
  - remnux.rubygems
  - remnux.scripts
  - remnux.config
  - remnux.tools

remnux-addon-version-file:
  file.managed:
    - name: /etc/sift-version
    - source: salt://VERSION
    - user: root
    - group: root
    - require:
      - sls: remnux.repos
      - sls: remnux.packages
      - sls: remnux.python-packages
      - sls: remnux.rubygems
      - sls: remnux.scripts
      - sls: remnux.config
      - sls: remnux.tools