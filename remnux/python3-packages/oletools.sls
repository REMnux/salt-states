# Name: oletools
# Website: https://www.decalage.info/python/oletools
# Description: Microsoft Office OLE2 compound documents.
# Category: Analyze Documents: Microsoft Office
# Author: Philippe Lagadec: https://x.com/decalage2
# License: Free, custom license: https://github.com/decalage2/oletools/blob/master/LICENSE.md
# Notes: mraptor, msodde, olebrowse, oledir, oleid, olemap, olemeta, oleobj, oletimes, olevba, pyxswf, rtfobj, ezhexviewer

{% set tools = ['mraptor','msodde','olebrowse','oledir','oleid','olemap','olemeta','oleobj','oletimes','olevba','pyxswf','rtfobj','ezhexviewer'] %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-tk
  - remnux.packages.libssl-dev
  - remnux.packages.libffi-dev
  - remnux.python3-packages.xlmmacrodeobfuscator

remnux-python3-packages-oletools-venv:
  virtualenv.managed:
    - name: /opt/oletools
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-oletools:
  pip.installed:
    - name: oletools
    - bin_env: /opt/oletools/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-oletools-venv

{% for tool in tools %}
remnux-python3-packages-oletools-symlink-{{ tool }}:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/oletools/bin/{{ tool }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-oletools
{% endfor %}
