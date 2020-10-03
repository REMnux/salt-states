# Name: The Sleuth Kit
# Website: https://www.sleuthkit.org/sleuthkit
# Description: A collection of command line tools and a C library that allows you to analyze disk images and recover files from them.
# Category: Examine Static Properties: General
# Author: Brian Carrier, and others
# License: the IBM Public License, the Common Public License, the GPL2: https://www.sleuthkit.org/sleuthkit/licenses.php
# Notes: 

include:
  - remnux.repos.gift

remnux-packages-sleuthkit:
  pkg.installed:
    - name: sleuthkit
    - pkgrepo: gift-repo
