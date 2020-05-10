remnux-config-objects:
  file.managed:
    - name: /usr/local/share/remnux/objects.js
    - source: salt://remnux/config/objects/objects.js
    - makedirs: True