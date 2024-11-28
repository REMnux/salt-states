# Name: INetSim
# Website: https://www.inetsim.org/
# Description: Emulate common network services and interact with malware.
# Category: Explore Network Interactions: Services
# Author: Thomas Hungenberg, Matthias Eckert
# License: GNU General Public License (GPL) v3
# Notes: inetsim

include:
  - remnux.repos.inetsim

remnux-packages-inetsim-repo:
  pkg.installed:
    - name: inetsim
    - version: latest
    - upgrade: True
    - refresh: True
    - pkgrepo: inetsim