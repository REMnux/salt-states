# Name: RATDecoders
# Website: https://github.com/kevthehermit/RATDecoders
# Description: Python3 Decoders for Remote Access Trojans
# Category: Examine Static Properties: Deobfuscation
# Author: Kevin Breen: https://twitter.com/KevTheHermit
# License: MIT License: https://github.com/kevthehermit/RATDecoders/blob/master/LICENSE
# Notes: malconf

{% if grains['oscodename'] == 'noble'%}

ratdecoders not yet available in Noble:
  test.nop

{% else %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-ratdecoders-venv:
  virtualenv.managed:
    - name: /opt/ratdecoders
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - androguard
      - pyperclip
      - yara-python
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-ratdecoders:
  pip.installed:
    - name: malwareconfig
    - bin_env: /opt/ratdecoders/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-ratdecoders-venv

remnux-python3-packages-ratdecoders-symlink:
  file.symlink:
    - name: /usr/local/bin/malconf
    - target: /opt/ratdecoders/bin/malconf
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-ratdecoders
{% endif %}
