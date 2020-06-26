# Name: FakeNet-NG
# Website: https://github.com/fireeye/flare-fakenet-ng
# Description: Emulate common network services and interact with malware.
# Category: Network Interactions
# Author: https://github.com/fireeye/flare-fakenet-ng/blob/master/AUTHORS
# License: https://github.com/fireeye/flare-fakenet-ng/blob/master/LICENSE.txt
# Notes: fakenet

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