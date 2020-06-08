# Name: XLMMacroDeobfuscator
# Website: https://github.com/DissectMalware/XLMMacroDeobfuscator
# Description: Deobfuscate XLM macros (also known as Excel 4.0 macros)
# Category: Document File Analysis
# Author: https://twitter.com/DissectMalware
# License: https://github.com/DissectMalware/XLMMacroDeobfuscator/blob/master/LICENSE
# Notes: xlmdeobfuscator

include:
  - remnux.packages.python3-pip
  - remnux.packages.python-pip

remnux-pip-xlmmacrodeobfuscator:
  pip.installed:
    - name: xlmmacrodeobfuscator
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python-pip