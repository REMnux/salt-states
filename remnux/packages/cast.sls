# Name: Cast
# Website: https://github.com/ekristen/cast
# Description: Install and manage SaltStack-based Linux distributions, including REMnux.
# Category: General Utilities
# Author: Erik Kristensen
# License: MIT License: https://github.com/ekristen/cast/blob/main/LICENSE
# Notes: cast

{% from "remnux/osarch.sls" import osarch with context %}
{% set version = "1.0.4" %}
{% if osarch == "amd64" %}
  {% set hash = "d8322b1fb05a352794cded7de934af682eaea2c5e1e42ca2ff5eb0f503136219" %}
{% elif osarch == "arm64" %}
  {% set hash = "68d17c7242835984bcdc3be48b8cbc3a6f03839abbcede0d29b99ec61511e8fb" %}
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

