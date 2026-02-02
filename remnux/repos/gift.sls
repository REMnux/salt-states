{% from "remnux/osarch.sls" import osarch with context %}
{% set version = "stable" %}

include:
  - remnux.packages.software-properties-common

{%- if version == "stable" %}
remnux-gift-dev:
  pkgrepo.absent:
    - ppa: gift/dev
    - require_in:
      - pkgrepo: gift-repo
{%- else %}
remnux-gift-stable:
  pkgrepo.absent:
    - ppa: gift/stable
    - require_in:
      - pkgrepo: gift-repo
{%- endif %}

remnux-remove-gift-list:
  file.absent:
    - name: /etc/apt/sources.list.d/gift-ubuntu-{{ version }}-{{ grains['lsb_distrib_codename'] }}.list
    - require_in:
      - pkgrepo: gift-repo

remnux-remove-gift-key:
  file.absent:
    - name: /usr/share/keyrings/GIFT-GPG-KEY.asc
    - require_in:
      - pkgrepo: gift-repo

gift-repo:
  pkgrepo.managed:
    - name: gift
    - ppa: gift/{{ version }}
    - keyid: 3ED1EAECE81894B171D7DA5B5E80511B10C598B8
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: remnux.packages.software-properties-common

remnux-gift-repo-preferences:
  file.managed:
    - name: /etc/apt/preferences.d/gift
    - source: salt://remnux/repos/files/gift.preferences
    - template: jinja
    - context:
        version: {{ version }}
