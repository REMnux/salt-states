# Name: UPX
# Website: https://upx.github.io
# Description: A popular tool for packing and unpacking executable files
# Category: Statically examine PE files: Unpacking
# Author: Markus Oberhumer, Laszlo Molnar
# License: https://github.com/upx/upx/blob/master/LICENSE
# Notes: upx

include:
  - remnux.repos.remnux
  
upx-ucl:
  pkg.installed:
    - pkgrepo: remnux