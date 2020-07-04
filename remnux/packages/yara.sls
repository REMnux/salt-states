# Name: Yara
# Website: https://virustotal.github.io/yara/
# Description: Identify and classify malware samples
# Category: Examine File Properties and Contents: Scan
# Author: https://github.com/VirusTotal/yara/blob/master/AUTHORS
# License: https://github.com/VirusTotal/yara/blob/master/COPYING
# Notes: yara

include:
  - remnux.repos.remnux

yara:
  pkg.installed:
    - pkgrepo: remnux