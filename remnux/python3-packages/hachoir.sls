# Name: Hachoir
# Website: https://github.com/vstinner/hachoir
# Description: View, edit, and carve contents of various binary file types.
# Category: Examine Static Properties: General, Analyze Documents: Microsoft Office
# Author: https://hachoir.readthedocs.io/en/latest/authors.html
# License: GNU General Public License (GPL) v2: https://github.com/vstinner/hachoir/blob/master/COPYING
# Notes: hachoir-metadata, hachoir-grep, hachoir-strip, hachoir-urwid, hachoir-wx. hachior-wx requires libgtk-3-0 and wxPython, but they are not installed.

{% set tools = ['hachoir-metadata','hachoir-grep','hachoir-strip','hachoir-urwid','hachoir-wx'] %}

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-hachoir-venv:
  virtualenv.managed:
    - name: /opt/hachoir
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - urwid
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-hachoir:
  pip.installed:
    - name: hachoir
    - bin_env: /opt/hachoir/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-hachoir-venv

{% for tool in tools %}
remnux-python3-packages-hachoir-{{ tool }}-symlink:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/hachoir/bin/{{ tool }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-hachoir
{% endfor %}
