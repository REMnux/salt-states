# Install all aspects of REMnux, include its customizations to the user experience.
# This is appropriate for systems dedicated to running REMnux or to systems locally.

include:
    - remnux.addon
    - remnux.theme
    - remnux.theme-dedicated

remnux-dedicated-version-file:
  file.managed:
    - name: /etc/remnux-version
    - source: salt://VERSION
    - user: root
    - group: root
    - require:
      - sls: remnux.addon
      - sls: remnux.theme
      - sls: remnux.theme-dedicated