{% from "remnux/osarch.sls" import osarch with context %}
{% if grains['oscodename'] == "focal" %}
{% set ver = "14" %}
{% set key = "nodesource.gpg.key" %}
{% set repo = "focal" %}
{% elif grains['oscodename'] == "noble" %}
{% set ver = "22" %}
{% set key = "nodesource-repo.gpg.key" %}
{% set repo = "nodistro" %}
{% endif %}

remnux-nodejs-key:
  file.managed:
    - name: /usr/share/keyrings/NODESOURCE-GPG.KEY
    - source: https://deb.nodesource.com/gpgkey/{{ key }}
    - skip_verify: True
    - makedirs: True

nodejs-repo-cleanup:
  pkgrepo.absent:
    - name: deb https://deb.nodesource.com/node_{{ ver }}.x {{ grains['lsb_distrib_codename'] }} main
    - refresh: true

nodejs-repo:
  pkgrepo.managed:
    - humanname: nodejs
    - name: deb [arch={{ osarch }} signed-by=/usr/share/keyrings/NODESOURCE-GPG.KEY] https://deb.nodesource.com/node_{{ ver }}.x {{ repo }} main
    - file: /etc/apt/sources.list.d/nodesource.list
    - refresh: True
    - clean_file: True
    - require:
      - pkgrepo: nodejs-repo-cleanup
      - file: remnux-nodejs-key
