# Name: UPX
# Website: https://upx.github.io
# Description: Pack and unpack PE files.
# Category: Statically Analyze Code: Unpacking
# Author: Markus Oberhumer, Laszlo Molnar
# License: GNU General Public License (GPL): https://github.com/upx/upx/blob/master/LICENSE
# Notes: upx

include:
  - remnux.repos.remnux
  
upx-ucl:
  pkg.installed:
    - pkgrepo: remnux