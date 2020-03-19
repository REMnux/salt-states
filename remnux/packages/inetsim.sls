# Name: INetSim
# Website: https://www.inetsim.org/
# Description: Emilate common network services.
# Category: Network Interactions
# Author: Thomas Hungenberg, Matthias Eckert
# License: https://www.gnu.org/licenses/gpl-3.0.txt
# Notes: 

include:
  - remnux.repos.inetsim

inetsim:
  pkg.installed:
    - pkgrepo: inetsim-repo
