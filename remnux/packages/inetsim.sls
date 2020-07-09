# Name: INetSim
# Website: https://www.inetsim.org/
# Description: Emulate common network services and interact with malware.
# Category: Explore Network Interactions
# Author: Thomas Hungenberg, Matthias Eckert
# License: https://www.gnu.org/licenses/gpl-3.0.txt
# Notes: inetsim

include:
  - remnux.repos.inetsim

inetsim:
  pkg.installed:
    - pkgrepo: inetsim-repo
