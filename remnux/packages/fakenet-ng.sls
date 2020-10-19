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
  - remnux.repos.remnux

fakenet-ng:
  pkg.installed:
    - pkgrepo: remnux
    - require:
      - sls: remnux.python-packages.cryptography

pydivert:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip

dnslib:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip

dpkt:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip

netfilterqueue:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip

pyftpdlib:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip

pyopenssl:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip
