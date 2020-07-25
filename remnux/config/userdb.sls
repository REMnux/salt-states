# Name: userdb.txt
# Website: https://github.com/cuckoosandbox/cuckoo/blob/master/cuckoo/private/peutils/UserDB.TXT
# Description: A database of signatures for identifying packers.
# Category: Examine Static Properties: PE Files
# Author: Unknown
# License: Free, unknown license.
# Notes: The databse is designed for the tool PEiD, but is also used by various other tools, such as pecheck.py. This version of the file is from the Cuckoo Sandbox project.

remnux-config-userdb:
  file.managed:
    - name: /usr/local/share/remnux/userdb.txt
    - source: https://raw.githubusercontent.com/cuckoosandbox/cuckoo/master/cuckoo/private/peutils/UserDB.TXT
    - source_hash: sha256=e3df02374544078a945d1593b9c08a02d94ae6a5c1fc4e7007235bea31a5d00f
    - makedirs: true
    - mode: 644