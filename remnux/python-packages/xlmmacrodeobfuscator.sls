# Name: XLMMacroDeobfuscator
# Website: https://github.com/DissectMalware/XLMMacroDeobfuscator
# Description: Deobfuscate XLM macros (also known as Excel 4.0 macros) from Microsoft Office files.
# Category: Analyze Documents: Microsoft Office
# Author: https://twitter.com/DissectMalware
# License: Apache License 2.0: https://github.com/DissectMalware/XLMMacroDeobfuscator/blob/master/LICENSE
# Notes: xlmdeobfuscator

include:
  - remnux.packages.python3-pip
  - remnux.packages.python-pip

remnux-pip-xlmmacrodeobfuscator:
  pip.installed:
    - name: xlmmacrodeobfuscator
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python-pip

/usr/local/bin/runxlrd2.py:
  file.managed:
    - replace: False
    - mode: 755
    - require:
      - pip: remnux-pip-xlmmacrodeobfuscator
