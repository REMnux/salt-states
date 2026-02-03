# Name: FLOSS
# Website: https://github.com/mandiant/flare-floss
# Description: Extract and deobfuscate strings from PE executables.
# Category: Examine Static Properties: Deobfuscation
# Author: FireEye Inc, Willi Ballenthin: https://x.com/williballenthin, Moritz Raabe
# License: Apache License 2.0: https://github.com/mandiant/flare-floss/blob/master/LICENSE.txt
# Notes: floss

include:
  - remnux.repos.remnux

remnux-packages-flare-floss:
  pkg.installed:
    - name: flare-floss
    - version: latest
    - upgrade: True
    - pkgrepo: remnux