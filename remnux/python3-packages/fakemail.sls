# Name: fakemail
# Website: https://hg.sr.ht/~olly/fakemail
# Description: Intercept and examine SMTP email activity with this fake SMTP server. Available in the REMnux distro based on Ubuntu 20.04 (Focal); not available on Ubuntu 18.04 (Bionic).
# Category: Explore Network Interactions: Services
# Author: Oliver Cope
# License: Apache License 2.0: https://hg.sr.ht/~olly/fakemail/browse/LICENSE.txt?rev=default
# Notes: 

{%- if grains['oscodename'] == "focal" %}

include:
  - remnux.packages.python3-pip

remnux-python3-packages-fakemail:
  pip.installed:
    - name: fakemail
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: remnux.packages.python3-pip

{%- elif grains['oscodename'] == "bionic" %}

remnux-python3-packages-fakemail:
  test.nop

{%- endif %}