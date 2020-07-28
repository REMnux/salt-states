# Name: FakeNet-NG
# Website: https://github.com/fireeye/flare-fakenet-ng
# Description: Emulate common network services and interact with malware.
# Category: Explore Network Interactions: Services
# Author: FireEye Inc, Peter Kacherginsky, Michael Bailey: https://github.com/fireeye/flare-fakenet-ng/blob/master/AUTHORS
# License: Apache License 2.0: https://github.com/fireeye/flare-fakenet-ng/blob/master/LICENSE.txt
# Notes: Run the tool using `sudo fakenet`. First, edit `/usr/lib/python2.7/dist-packages/fakenet/configs/default.ini`, changing the `LinuxRestrictInterface` parameter to your Ethernet network interface name, such as `ens33`.

include:
  - remnux.packages.python-pip
  - remnux.repos.remnux

fakenet-ng:
  pkg.installed:
    - pkgrepo: remnux

pydivert:
  pip.installed

dnslib:
  pip.installed

dpkt:
  pip.installed

netfilterqueue:
  pip.installed