include:
  - remnux.packages.docker

remnux-theme-cleanup-autoremove:
  cmd.run:
    - name: apt-get autoremove -y

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

remnux-theme-cleanup-service-bluetooth:
  service.dead:
    - name: bluetooth
    - enable: False

remnux-theme-cleanup-service-bluetooth
  service.dead:
    - name: docker
    - enable: False
    - require:
      - sls: remnux.packages.docker

remnux-theme-cleanup-docker-wrapper:
  file.managed:
    - replace: False
    - user: root
    - group: root
    - mode: 755
    - name: /usr/local/bin/docker
    - source: salt://remnux/theme/cleanup/docker-wrapper.sh
    - makedirs: True
    - require:
      - sls: remnux.packages.docker

{% endif %}