# Name: EvilClippy
# Website: https://github.com/outflanknl/EvilClippy
# Description: Modify aspects of Microsoft Office documents.
# Category: Analyze Documents: Microsoft Office
# Author: Stan Hegt: https://twitter.com/StanHacked, with contributions from Carrie Roberts: https://twitter.com/OrOneEqualsOne
# License: GNU General Public License (GPL) v3.0: https://github.com/outflanknl/EvilClippy/blob/master/LICENSE.md
# Notes: To remove VBA project password protection from the file, use the `evilclippy -uu` command.

include:
  - remnux.repos.remnux
  - remnux.packages.mono-devel

remnux-packages-evilclippy:
  pkg.installed:
    - name: evilclippy
    - version: latest
    - upgrade: True
    - pkgrepo: remnux
    - require:
      - sls: remnux.packages.mono-devel