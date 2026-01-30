# Name: readpe (formerly pev)
# Website: https://github.com/mentebinaria/readpe
# Description: Analyze PE files and extract strings from them.
# Category: Examine Static Properties: PE Files
# Author: Fernando Merces, Jardel Weyrich
# License: GNU General Public License (GPL) v2: https://github.com/mentebinaria/readpe/blob/master/LICENSE
# Notes: readpe, pestr, pedis, pehash, pescan, pesec, peldd, pepack, peres, ofs2rva, rva2ofs

include:
  - remnux.repos.remnux
  
remnux-packages-pev:
  pkg.installed:
    - name: pev
    - version: latest
    - upgrade: True
    - pkgrepo: remnux

remnux-packages-pev-plugins-dir:
  file.directory:
    - name: /usr/local/lib/pev
    - makedirs: True
    - require:
      - pkg: remnux-packages-pev

remnux-packages-pev-plugins-symlink:
  file.symlink:
    - name: /usr/local/lib/pev/plugins
    - target: /usr/lib/pev/plugins
    - force: True
    - makedirs: False
    - require:
      - file: remnux-packages-pev-plugins-dir
