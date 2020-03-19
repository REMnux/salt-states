# Name: FLOSS
# Website: https://github.com/fireeye/flare-floss
# Description: Extract and deobfuscate strings from binaries.
# Category: Artifact Extraction and Decoding
# Author: Willi Ballenthin: https://twitter.com/williballenthin, Moritz Raabe
# License: https://github.com/fireeye/flare-floss/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.python-packages.vivisect

remnux-pip-flare-floss:
  pip.installed:
    - name: git+https://github.com/fireeye/flare-floss.git@master
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.python-packages.vivisect
