# Name: restrict-egress
# Website: https://github.com/REMnux/distro/blob/master/files/restrict-egress
# Description: Restrict the host's outbound network access to an allowlist of domains and CIDRs, using an nftables default-deny egress policy that survives reboots and re-resolves load-balanced endpoints. Requires systemd, so it runs on a host or VM only and is not functional inside containers.
# Category: General Utilities
# Author: Lenny Zeltser: https://x.com/lennyzeltser
# License: MIT
# Notes: Not active by default. Define allowed destinations in /etc/restrict-egress.conf, then enable with `restrict-egress on` (as root) and disable with `restrict-egress off` before apt or remnux install. Requires systemd, so not functional inside containers.

include:
  - remnux.packages.nftables
  - remnux.packages.python3

remnux-scripts-restrict-egress-source:
  file.managed:
    - name: /usr/local/bin/restrict-egress
    - source: https://github.com/REMnux/distro/raw/master/files/restrict-egress
    - source_hash: sha256=760d7d8b6b4b12336d119bc92954b98e79fbc4e3fdff89cdc01327cb1540378e
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.nftables
      - sls: remnux.packages.python3
