# Name: STPyV8
# Website: https://github.com/cloudflare/stpyv8
# Description: Python3 and JavaScript interop engine, fork of the original PyV8 project.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Area1 Security
# License: Apache License 2.0: https://github.com/cloudflare/stpyv8/blob/master/LICENSE.txt
# Notes:

{% macro install_stpyv8(version, hash, pyenv, py_ver) %}
{% if grains['oscodename'] == 'focal' %}
  {%- set rel = grains['osrelease'] %}
  {%- set py = py_ver.replace(".","") %}
  {%- set wheel = "stpyv8-" + version + "-cp" + py + "-cp" + py + "-linux_x86_64.whl" %}
  {%- set release = "stpyv8-ubuntu-" + rel + "-python-" + py_ver + ".zip" %}
  {%- set folder = "stpyv8-ubuntu-" + rel + "-" + py_ver %}
{% else %}
  {% set py = py_ver.replace(".","") %}
  {%- set release = "stpyv8-" + version + "-cp" + py + "-cp" + py + "-manylinux_2_31_x86_64.whl" %}
{% endif %}

stpyv8-requirements-{{ pyenv }}:
  pkg.installed:
    - names:
      - libboost-python-dev
      - libboost-system-dev
      - libboost-iostreams-dev
      - libboost-dev
      - build-essential

remnux-python3-packages-stpyv8-source-{{ pyenv }}:
  file.managed:
    - name: /usr/local/src/remnux/files/{{ release }}
    - source: https://github.com/cloudflare/stpyv8/releases/download/v{{ version }}/{{ release }}
    - source_hash: sha256={{ hash }}
    - makedirs: True

{% if grains['oscodename'] == 'focal' %}
remnux-python3-packages-stpyv8-archive-{{ pyenv }}:
  archive.extracted:
    - name: /usr/local/src/remnux/
    - source: /usr/local/src/remnux/files/{{ release }}
    - enforce_toplevel: False
    - watch:
      - file: remnux-python3-packages-stpyv8-source-{{ pyenv }}

remnux-python3-packages-stpyv8-focal-{{ pyenv }}:
  pip.installed:
    - name: /usr/local/src/remnux/{{ folder }}/{{ wheel }}
    - bin_env: {{ pyenv }}

{% else %}
remnux-python3-packages-stpyv8-{{ pyenv }}:
  pip.installed:
    - name: /usr/local/src/remnux/files/{{ release }}
    - bin_env: {{ pyenv }}
{% endif %}
{% endmacro %}
