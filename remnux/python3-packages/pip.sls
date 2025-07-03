include:
  - remnux.packages.python3-pip

{% if grains['oscodename'] == 'focal' %}
remnux-python3-packages-pip3:
  pip.installed:
    - name: pip>=24.1.3
    - bin_env: /usr/bin/python3
    - upgrade: True
    - force_reinstall: True
    - require:
      - sls: remnux.packages.python3-pip
{% endif %}
