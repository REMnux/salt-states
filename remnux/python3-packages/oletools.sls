# Name: oletools
# Website: http://www.decalage.info/python/oletools
# Description: Microsoft Office OLE2 compound documents.
# Category: Analyze Documents: Microsoft Office
# Author: Philippe Lagadec: https://twitter.com/decalage2
# License: Free, custom license: https://github.com/decalage2/oletools/blob/master/LICENSE.md
# Notes: mraptor, msodde, olebrowse, oledir, oleid, olemap, olemeta, oleobj, oletimes, olevba, pyxswf, rtfobj, ezhexviewer
{% if grains['oscodename'] == "focal" %}
  {% set python = "python3.8" %}
{% elif grains['oscodename'] == "bionic" %}
  {% set python = "python3.6" %}
{% endif %}

include:
  - remnux.python3-packages.pip
  - remnux.packages.python3-tk
  - remnux.packages.libssl-dev
  - remnux.packages.libffi-dev
  - remnux.python3-packages.xlmmacrodeobfuscator

remnux-python3-packages-oletools:
  pip.installed:
    - name: oletools
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.python3-tk
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.libffi-dev
      - sls: remnux.python3-packages.xlmmacrodeobfuscator

remnux-python3-packages-oletools-cleanup:
  file.line:
    - name: /usr/local/lib/{{ python }}/dist-packages/oletools/olevba.py
    - mode: delete
    - content: "log.warning('For now, VBA stomping cannot be detected for files in memory')"
    - require:
      - pip: remnux-python3-packages-oletools
