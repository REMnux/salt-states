# Install all aspects of REMnux, include its customizations to the user experience.
# This is appropriate for systems dedicated to running REMnux or to systems.

include:
    - remnux.addon
    - remnux.theme

remnux-standalone-version-file:
  file.managed:
    - name: /etc/sift-version
    - source: salt://VERSION
    - user: root
    - group: root
    - require:
      - sls: remnux.addon
      - sls: remnux.theme