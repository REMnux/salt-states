# Name: Frida
# Website: https://frida.re
# Description: Trace the execution of a process to analyze its behavior.
# Category: Dynamically Reverse-Engineer Code: General
# Author: Ole Andre Vadla Ravnas
# License: wxWindows Library License 3.1: https://github.com/frida/frida/blob/main/COPYING
# Notes: frida, frida-ps, frida-trace, frida-discover, frida-ls-devices, frida-kill
{% set tools = ['frida', 'frida-ps', 'frida-trace', 'frida-discover', 'frida-ls-devices', 'frida-kill', 'frida-apk', 'frida-compile', 'frida-create', 'frida-itrace', 'frida-join', 'frida-ls', 'frida-pull', 'frida-push', 'frida-rm'] %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-frida-venv:
  virtualenv.managed:
    - name: /opt/frida
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-frida:
  pip.installed:
    - name: frida-tools
    - bin_env: /opt/frida/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-frida-venv

{% for tool in tools %}
remnux-python3-packages-frida-{{ tool }}-symlink:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/frida/bin/{{ tool }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-frida
{% endfor %}
