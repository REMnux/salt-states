# Name: XLMMacroDeobfuscator
# Website: https://github.com/DissectMalware/XLMMacroDeobfuscator
# Description: Deobfuscate XLM macros (also known as Excel 4.0 macros) from Microsoft Office files.
# Category: Analyze Documents: Microsoft Office
# Author: https://twitter.com/DissectMalware
# License: Apache License 2.0: https://github.com/DissectMalware/XLMMacroDeobfuscator/blob/master/LICENSE
# Notes: xlmdeobfuscator
{%- if grains['oscodename'] == "focal" %}
  {% set python = "python3.8" %}
{%- elif grains['oscodename'] == "bionic" %}
  {% set python = "python3.6" %}
{% endif %}

include:
  - remnux.python3-packages.pip

remnux-python3-packages-xlmmacrodeobfuscator:
  pip.installed:
    - name: xlmmacrodeobfuscator
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.python3-packages.pip

/usr/local/bin/runxlrd2.py:
  file.managed:
    - replace: False
    - mode: 755
    - require:
      - pip: remnux-python3-packages-xlmmacrodeobfuscator

remnux-python3-packages-xlmmacrodeobfuscator-cleanup:
  file.line:
    - name: /usr/local/lib/{{ python }}/dist-packages/XLMMacroDeobfuscator/deobfuscator.py
    - mode: delete
    - content: "print('pywin32 is not installed (only is required if you want to use MS Excel)')"
    - require:
      - pip: remnux-python3-packages-xlmmacrodeobfuscator
