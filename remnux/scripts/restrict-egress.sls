# Name: restrict-egress
# Website: https://github.com/REMnux/distro/blob/master/files/restrict-egress
# Description: Restrict outbound network access to an allowlist of domains and CIDRs using an nftables default-deny egress policy. It installs a persistent, self-refreshing lockdown on a VM or host, or enforces a one-shot lockdown inside a container with the apply command. Where dnsmasq and systemd-resolved are present, domain entries are coupled to DNS: a local dnsmasq inserts each answered IP into the allow set before the client sees it, so rotating load-balancer addresses never miss.
# Category: General Utilities
# Author: Lenny Zeltser: https://x.com/lennyzeltser
# License: MIT
# Notes: Not active by default. Define allowed destinations in /etc/restrict-egress.conf, then enable with `restrict-egress on` (as root) and disable with `restrict-egress off` before apt or remnux install. `restrict-egress diagnose` explains why a name cannot be reached through the lockdown. In a container (no systemd), use `restrict-egress apply` and run the container with --cap-add=NET_ADMIN.

include:
  - remnux.packages.nftables
  - remnux.packages.dnsmasq-base
  - remnux.packages.python3

remnux-scripts-restrict-egress-source:
  file.managed:
    - name: /usr/local/bin/restrict-egress
    - source: https://github.com/REMnux/distro/raw/master/files/restrict-egress
    - source_hash: sha256=7d55b9762e7b6f8b9f383ba5c613c52f0b1c8a1127b1fa5ba1d1e74ec6bbd41b
    - makedirs: false
    - mode: 755
    - require:
      - sls: remnux.packages.nftables
      - sls: remnux.packages.dnsmasq-base
      - sls: remnux.packages.python3
