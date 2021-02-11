# Name: capa
# Website: https://github.com/fireeye/capa
# Description: Detect suspicious capabilites in PE files.
# Category: Statically Analyze Code: PE Files
# Author: FireEye Inc, Willi Ballenthin: https://twitter.com/williballenthin, Moritz Raabe: https://twitter.com/m_r_tz
# License: Apache License 2.0: https://github.com/fireeye/capa/blob/master/LICENSE.txt
# Notes: 

include:
  - remnux.repos.remnux
  
remnux-packages-capa:
  pkg.installed:
    - name: capa
    - version: latest
    - upgrade: True
    - pkgrepo: remnux