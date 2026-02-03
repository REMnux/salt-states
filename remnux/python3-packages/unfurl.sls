# Name: Unfurl
# Website: https://github.com/obsidianforensics/unfurl
# Description: Deconstruct and decode data from a URL.
# Category: Explore Network Interactions: Connecting
# Author: Ryan Benson: https://x.com/_RyanBenson
# License: Apache License 2.0: https://github.com/obsidianforensics/unfurl/blob/master/LICENSE
# Notes: For the command-line version of the tool, run `unfurl_cli.py`. For the local browser-based version, run `unfurl_app.py`.

{% if grains['oscodename'] == 'noble' %}
  {% set tools = ['unfurl','unfurl_app'] %}
{% elif grains['oscodename'] == 'focal' %}
  {% set tools = ['unfurl_cli.py', 'unfurl_app.py'] %}
{% endif %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-unfurl-venv:
  virtualenv.managed:
    - name: /opt/unfurl
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - protobuf
      - flask
      - flask_cors
      - flask_restx
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-unfurl:
  pip.installed:
    - name: dfir-unfurl
    - bin_env: /opt/unfurl/bin/python3
    - upgrade: True
    - ignore_installed: True
    - require:
      - virtualenv: remnux-python3-packages-unfurl-venv

{% for tool in tools %}
remnux-python3-packages-unfurl-symlink-{{ tool }}:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/unfurl/bin/{{ tool }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-unfurl
{% endfor %}
