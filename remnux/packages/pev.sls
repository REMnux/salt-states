# Name: pev
# Website: https://github.com/mentebinaria/readpe
# Description: Analyze PE files and extract strings from them
# Category: Examine Static Properties: PE Files
# Author: Fernando Merces, Jardel Weyrich
# License: GNU General Public License (GPL) v2: https://github.com/mentebinaria/readpe/blob/master/LICENSE
# Notes: pestr, readpe, pedis, pehash, pescan, peldd, peres

include:
  - remnux.repos.remnux
  
remnux-packages-pev:
  pkg.installed:
    - name: pev
    - version: latest
    - upgrade: True
    - pkgrepo: remnux
