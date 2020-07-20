# Install all aspects of REMnux, include its customizations to the user experience.
# This is appropriate for systems dedicated to running REMnux or to systems in a cloud.

include:
    - remnux.addon
    - remnux.theme

remnux-cloud:
  test.nop:
    - require:
      - sls: remnux.addon
      - sls: remnux.theme