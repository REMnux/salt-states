# Name: Yara
# Website: https://virustotal.github.io/yara/
# Description: Identify and classify malware samples using Yara rules.
# Category: Gather and Analyze Data
# Author: https://github.com/VirusTotal/yara/blob/master/AUTHORS
# License: BSD 3-Clause "New" or "Revised" License: https://github.com/VirusTotal/yara/blob/master/COPYING
# Notes: yara

include:
  - remnux.repos.remnux

yara:
  pkg.installed:
    - pkgrepo: remnux