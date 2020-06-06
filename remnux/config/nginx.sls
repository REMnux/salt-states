include:
  - remnux.packages.nginx

remnux-config-nginx-workers:
  file.replace:
    - name: /etc/nginx/nginx.conf
    - pattern: 'worker_processes auto;'
    - repl: 'worker_processes 1;'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - sls: remnux.packages.nginx

remnux-config-nginx-sites-root:
  file.replace:
    - name: /etc/nginx/sites-enabled/default
    - pattern: '\tlocation / {'
    - repl: '\tlocation / {\n\t\tautoindex on;'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - sls: remnux.packages.nginx