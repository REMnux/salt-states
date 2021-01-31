# Name: pev
# Website: http://pev.sourceforge.net
# Description: Analyze PE files and extract strings from them
# Category: Examine Static Properties: PE Files
# Author: Fernando Merces, Jardel Weyrich
# License: GNU General Public License (GPL) v2: https://github.com/merces/pev/blob/master/LICENSE
# Notes: pestr, readpe, pedis, pehash, pescan, peldd, peres

include:
  - remnux.repos.remnux
  
remnux-packages-pev-repo:
  pkgrepo.managed:
    - name: remnux
    - ppa: remnux/stable
 
remnux-packages-pev:
  pkg.installed:
    - name: pev
    - require:
      - pkgrepo: remnux