# Name: Nginx
# Website: https://nginx.org
# Description: Web server
# Category: Explore Network Interactions: Services
# Author: Igor Sysoev, Nginx Inc.
# License: Free, custom license: https://nginx.org/LICENSE
# Notes: httpd <start|stop|status>

nginx:
  pkg.installed

# Runlevel isn't in a Docker container, so check whether it exists before
# trying to control  services
{%- if salt['file.file_exists']('/sbin/runlevel') %}

nginx-service:
  service.dead:
    - name: nginx
    - enable: False
    - watch:
      - pkg: nginx

{% endif %}