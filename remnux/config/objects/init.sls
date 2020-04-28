remnux-config-objects:
  file.managed:
    - name: /usr/share/remnux/objects.js
    - source: salt://remnux/config/objects/objects.js
    - makedirs: True