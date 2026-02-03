# Name: Manalyze
# Website: https://github.com/JusticeRage/Manalyze
# Description: Perform static analysis of suspicious PE files.
# Category: Examine Static Properties: PE Files
# Author: Ivan Kwiatkowski: https://x.com/JusticeRage
# License: GNU General Public License (GPL) v3: https://github.com/JusticeRage/Manalyze/blob/master/LICENSE.txt
# Notes: Run "manalyze" to invoke the tool. To update the tool's Yara rules to include ClamAV, run "sudo python3 /usr/share/manalyze/yara_rules/update_clamav_signatures.py". To query VirusTotal, add your API key to /etc/manalyze/manalyze.conf.

{% if grains['oscodename'] == 'focal' %}

manalyze installed via pre-built binaries on Focal:
  test.nop

{% else %}

include:
  - remnux.repos.remnux

manalyze:
  pkg.installed:
    - version: latest
    - upgrade: True
    - pkgrepo: remnux

{% endif %}
