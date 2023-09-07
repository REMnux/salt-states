# Name: dissect
# Website: https://github.com/fox-it/dissect
# Description: Dissect is a digital forensics & incident response framework and
# toolset that allows you to quickly access and analyse forensic artefacts from
# various disk and file formats, developed by Fox-IT (part of NCC Group).
# Category: Perform system analysis
# Author: Dissect Team: dissect@fox-it.com
# License: Affero General Public License v3: https://github.com/fox-it/dissect/blob/main/LICENSE
# Notes: target-query, target-shell, target-dump, target-info, target-reg, target-dd, target-mount

{%- if grains['oscodename'] == "focal" %}
  {%- set python3_version="python3.9" %}
  {%- set python3_dependency="python39" %} 
{%- else %}
  {%- set python3_version="python3" %}
  {%- set python3_dependency="python3" %} 
{% endif %}

include:
  - remnux.python3-packages.pip
  - remnux.packages.python3-virtualenv
  - remnux.packages.{{ python3_dependency }}
  - remnux.packages.libfuse2

# Create a virtualenv for dissect
remnux-python3-packages-dissect-virtualenv:
  virtualenv.managed:
    - name: /opt/dissect
    - python: /usr/bin/{{ python3_version }}
    - pip_pkgs:
      - pip
      - setuptools
      - wheel
    - require:
      - sls: remnux.packages.{{ python3_dependency }}
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.python3-virtualenv

# Install dissect inside the virtualenv
remnux-python3-packages-dissect-install:
  pip.installed:
    - name: dissect
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
