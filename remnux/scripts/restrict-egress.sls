# Name: restrict-egress
# Website: https://github.com/REMnux/distro/blob/master/files/restrict-egress
# Description: Restrict outbound network access to an allowlist of domains and CIDRs using an nftables default-deny egress policy. It installs a persistent, self-refreshing lockdown on a VM or host, or enforces a one-shot lockdown inside a container with the apply command.
# Category: General Utilities
# Author: Lenny Zeltser: https://x.com/lennyzeltser
# License: MIT
# Notes: Not active by default. Define allowed destinations in /etc/restrict-egress.conf, then enable with `restrict-egress on` (as root) and disable with `restrict-egress off` before apt or remnux install. In a container (no systemd), use `restrict-egress apply` and run the container with --cap-add=NET_ADMIN.

include:
  - remnux.packages.nftables
  - remnux.packages.python3

remnux-scripts-restrict-egress-source:
  file.managed:
    - name: /usr/local/bin/restrict-egress
    - source: https://github.com/REMnux/distro/raw/master/files/restrict-egress
    - source_hash: sha256=fc9db0956e9f014a2fc4144a13d65f6715bbde54298fb51e2f47c914f2f7cf2f
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.nftables
      - sls: remnux.packages.python3
