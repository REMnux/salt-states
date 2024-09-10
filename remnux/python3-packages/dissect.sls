# Name: dissect
# Website: https://github.com/fox-it/dissect
# Description: Perform a variety of forensics and incident response tasks using this DFIR framework and toolset.
# Category: Gather and Analyze Data
# Author: Dissect Team: dissect@fox-it.com
# License: GNU Affero General Public License v3: https://github.com/fox-it/dissect/blob/main/LICENSE
# Notes: acquire, target-fs, rdump, rgeoip, target-query, target-shell, target-dump, target-info, target-reg, target-dd, target-mount

{% set tools = ['acquire','target-query','target-shell','target-fs','target-reg','target-dump','target-dd','target-mount','rdump','rgeoip'] %}

{% if grains['oscodename'] == "focal" %}
  {% set py3_version="python3.9" %}
  {% set py3_dependency="python39" %} 
{% else %}
  {% set py3_version="python3" %}
  {% set py3_dependency="python3" %} 
{% endif %}

include:
  - remnux.python3-packages.pip
#  - remnux.packages.python3-virtualenv
  - remnux.packages.virtualenv
  - remnux.packages.{{ py3_dependency }}
  - remnux.packages.libfuse2

# Create a virtualenv for dissect
remnux-python3-packages-dissect-virtualenv:
  virtualenv.managed:
    - name: /opt/dissect
    - python: /usr/bin/{{ py3_version }}
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=23.1.2
      - setuptools==67.7.2
      - wheel==0.38.4
      - tzdata
    - require:
      - sls: remnux.packages.{{ py3_dependency }}
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.python3-virtualenv

# Install dissect inside the virtualenv
remnux-python3-packages-dissect-install:
  pip.installed:
    - names:
      - dissect
      - maxminddb
      - acquire
    - bin_env: /opt/dissect/bin/python3
    - upgrade: True
    - user: root
    - require:
      - virtualenv: remnux-python3-packages-dissect-virtualenv

remnux-python3-packages-dissect-venv-shortcut:
  file.managed:
    - name: /etc/profile.d/dissect-venv.sh
    - source: salt://remnux/config/dissect-venv.sh
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-dissect-install

{% for tool in tools %}
remnux-python3-packages-dissect-{{ tool }}-symlink:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/dissect/bin/{{ tool }}
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-dissect-install
{% endfor %}
