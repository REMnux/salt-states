# Name: Vivisect
# Website: https://github.com/vivisect/vivisect
# Description: Statically examine and emulate binary files.
# Category: Statically Analyze Code: General
# Author: invisigoth: invisigoth@kenshoto.com, installable vivisect module by Willi Ballenthin: https://x.com/williballenthin
# License: Apache License 2.0: https://github.com/vivisect/vivisect/blob/master/LICENSE.txt
# Notes: vivbin, vdbbin

{% set files = ['vivbin','vdbbin'] %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-package-vivisect-venv:
  virtualenv.managed:
    - name: /opt/vivisect
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-vivisect:
  pip.installed:
    - name: vivisect[gui]
    - bin_env: /opt/vivisect/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-vivisect-venv

{% for file in files %}
remnux-python3-package-vivisect-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/vivisect/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-package-vivisect
{% endfor %}
