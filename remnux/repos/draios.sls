remnux-draios-key:
  file.managed:
    - name: /usr/share/keyrings/DRAIOS-GPG-KEY.asc
    - source: salt://remnux/repos/files/DRAIOS-GPG-KEY.asc
    - skip_verify: True
    - makedirs: True

draios:
  pkgrepo.managed:
    - humanname: Draios
    - name: deb [arch={{ grains['osarch'] }} signed-by=/usr/share/keyrings/DRAIOS-GPG-KEY.asc] http://download.draios.com/stable/deb stable-{{ grains['osarch'] }}/
    - file: /etc/apt/sources.list.d/draios.list
    - refresh: true
    - require:
      - file: remnux-draios-key
