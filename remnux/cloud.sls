# Install all aspects of REMnux, include its customizations to the user experience.
# This is appropriate for systems dedicated to running REMnux or to systems in a cloud.

include:
    - remnux.addon
    - remnux.theme

remnux-dedicated-version-file:
  file.managed:
    - name: /etc/remnux-version
    - source: salt://VERSION
    - user: root
    - group: root
    - require:
      - sls: remnux.addon
      - sls: remnux.theme