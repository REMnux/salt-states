# Name: FakeNet-NG
# Website: https://github.com/fireeye/flare-fakenet-ng
# Description: Emulate common network services and interact with malware.
# Category: Explore Network Interactions: Services
# Author: FireEye Inc, Peter Kacherginsky, Michael Bailey: https://github.com/fireeye/flare-fakenet-ng/blob/master/AUTHORS
# License: Apache License 2.0: https://github.com/fireeye/flare-fakenet-ng/blob/master/LICENSE.txt
# Notes: Run the tool using `sudo fakenet`. First, edit `/usr/lib/python2.7/dist-packages/fakenet/configs/default.ini`, changing the `LinuxRestrictInterface` parameter to your Ethernet network interface name, such as `ens33`.

include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip
  - remnux.python-packages.cryptography
  - remnux.packages.build-essential
  - remnux.packages.libnetfilter-queue-dev
  - remnux.packages.libnfnetlink-dev
  - remnux.packages.git
{% if grains['oscodename'] == "bionic" %}
  - remnux.packages.python-dev
{% elif grains['oscodename'] == "focal" %}
  - remnux.packages.python2-dev
{% endif %}

remnux-python-packages-fakenet-requirements:
  pip.installed:
    - names:
      - pydivert
      - dnslib
      - dpkt
      - netfilterqueue
      - pyftpdlib
      - pyopenssl
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip

fakenet-ng:
  pip.installed:
    - name: git+https://github.com/fireeye/flare-fakenet-ng.git
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python2-pip
      - sls: remnux.python-packages.cryptography
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.libnetfilter-queue-dev
      - sls: remnux.packages.libnfnetlink-dev
