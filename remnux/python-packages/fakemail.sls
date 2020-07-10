# Name: fakemail
# Website: https://hg.sr.ht/~olly/fakemail
# Description: Intercept and examine SMTP email activity with this fake SMTP server.
# Category: Explore Network Interactions: Services
# Author: Oliver Cope
# License: Apache License 2.0: https://hg.sr.ht/~olly/fakemail/browse/LICENSE.txt?rev=default
# Notes: 

include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip

remnux-pip-fakemail:
  pip.installed:
    - name: fakemail
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python3-pip

