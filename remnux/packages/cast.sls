# Name: Cast
# Website: https://github.com/ekristen/cast
# Description: Install and manage SaltStack-based Linux distributions, including REMnux.
# Category: General Utilities
# Author: Erik Kristensen
# License: MIT License: https://github.com/ekristen/cast/blob/main/LICENSE
# Notes: cast

{% from "remnux/osarch.sls" import osarch with context %}
{% set version = "1.0.0" %}
{% if osarch == "amd64" %}
  {% set hash = "8d73856e4eef8a66d305861c6c81c763e5a3eea121a0f492ddf7caa11084a280" %}
{% elif osarch == "arm64" %}
  {% set hash = "c3212e562ce3d5120b24b9fa3d2e3b3a8e1869a96d2351cd1b7344c037b8ba9f" %}
{% endif %}

remnux-packages-cast-source:
  file.managed:
    - name: /usr/local/src/cast-v{{ version }}-linux-{{ osarch }}.deb
    - source: https://github.com/ekristen/cast/releases/download/v{{ version }}/cast-v{{ version }}-linux-{{ osarch }}.deb
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-packages-cast:
  pkg.installed:
    - sources:
      - cast: /usr/local/src/cast-v{{ version }}-linux-{{ osarch }}.deb
    - require:
      - file: remnux-packages-cast-source

