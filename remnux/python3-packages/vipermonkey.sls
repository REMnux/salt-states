# Name: ViperMonkey
# Website: https://www.decalage.info/en/vba_emulation
# Description: A VBA parser and emulation engine to analyze malicious macros.
# Category: Analyze Documents: Microsoft Office
# Author: Philippe Lagadec: https://twitter.com/decalage2
# License: Free, custom license: https://github.com/decalage2/ViperMonkey#license
# Notes: Only available on older version of REMnux based on Ubuntu 20.04 (Focal). vmonkey
{% if grains['oscodename'] == 'noble'%}

vipermonkey not yet available in Noble:
  test.nop

{% else %}

{% set files = ['vmonkey','vbashell'] %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.git

remnux-remove-previous-vipermonkey-venv:
  file.absent:
    - name: /opt/vipermonkey

remnux-python3-package-vipermonkey-venv:
  virtualenv.managed:
    - name: /opt/vipermonkey
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv
      - file: remnux-remove-previous-vipermonkey-venv

remnux-python3-package-vipermonkey:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/ViperMonkey.git
    - bin_env: /opt/vipermonkey/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-vipermonkey-venv
      - sls: remnux.packages.git

{% for file in files %}
remnux-python3-package-vipermonkey-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/vipermonkey/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-package-vipermonkey
{% endfor %}
{% endif %}
