# Name: mitmproxy
# Website: https://mitmproxy.org/
# Description: Investigate website interactions using this web proxy.
# Category: Explore Network Interactions: Monitoring
# Author: https://github.com/orgs/mitmproxy/people
# License: MIT License: https://github.com/mitmproxy/mitmproxy/blob/main/LICENSE
# Notes: mitmproxy, mitmdump, mitmweb

{% set tools = ['mitmproxy','mitmdump','mitmweb','mitmproxy-linux-redirector'] %}
{% if grains['oscodename'] == 'focal' %}
  {% set version = '12.1.1' %}
  {% set hash = 'cdbc5a92c87c63bb8fe13552b46d2d0afaa762193ddabe4c96df8f59690ffd76' %}

remnux-mitmproxy-source:
  file.managed.:
    - name: /usr/local/src/remnux/files/mitmproxy-{{ version }}-linux-x86_64.tar.gz
    - source: https://downloads.mitmproxy.org/{{ version }}/mitmproxy-{{ version }}-linux-x86_64.tar.gz
    - source_hash: sha256={{ hash }}
    - makedirs: True

remnux-mitmproxy-archive:
  archive.extracted:
    - name: /usr/local/bin/
    - source: /usr/local/src/remnux/files/mitmproxy-{{ version }}-linux-x86_64.tar.gz
    - enforce_toplevel: False
    - force: True
    - watch:
      - file: remnux-mitmproxy-source

remnux-mitmproxy-file-permissions:
  file.managed:
    - replace: False
    - names:
      - /usr/local/bin/mitmproxy
      - /usr/local/bin/mitmdump
      - /usr/local/bin/mitmweb
    - mode: 755
    - watch:
      - archive: remnux-mitmproxy-archive

{% else %}
include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-mitmproxy-venv:
  virtualenv.managed:
    - name: /opt/mitmproxy
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-mitmproxy:
  pip.installed:
    - name: mitmproxy
    - bin_env: /opt/mitmproxy/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-mitmproxy-venv

{% for tool in tools %}
remnux-python3-packages-mitmproxy-symlink-{{ tool }}:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/mitmproxy/bin/{{ tool }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-mitmproxy
{% endfor %}
{% endif %}
