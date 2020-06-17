# Name: oletools
# Website: http://www.decalage.info/python/oletools
# Description: Package of python tools to analyse Microsoft OLE2 files
# Category: Examine document files: Microsoft Office
# Author: Philippe Lagadec
# License: https://github.com/decalage2/oletools/blob/master/LICENSE.md
# Notes: mraptor, msodde, olebrowse, oledir, oleid, olemap, olemeta, oleobj, oletimes, olevba, pyxswf, rtfobj

include:
  - remnux.packages.python3-pip
  - remnux.packages.python3-tk
  - remnux.packages.python-pip

oletools:
  pip.installed:
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python3-tk
