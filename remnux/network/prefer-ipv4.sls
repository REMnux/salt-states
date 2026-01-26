# Name: Prefer IPv4 Configuration
# Website: https://remnux.org/
# Description: Configure system to prefer IPv4 over IPv6 for network connections.
# Author: REMnux Project
# License: MIT License
#
# This improves reliability in environments where IPv6 is partially configured
# but not fully routable (common in nested VMs, containers, overlay networks).
# IPv6 still works as a fallback if IPv4 is unavailable.
#
# Technical details:
# - Sets IPv4-mapped addresses (::ffff:0:0/96) to precedence 100
# - Default IPv6 precedence is 40, so IPv4 is tried first
# - Per RFC 6724, higher precedence = preferred
# - Does NOT disable IPv6, only changes address selection order

remnux-network-prefer-ipv4:
  file.append:
    - name: /etc/gai.conf
    - text: |

        # REMnux: Prefer IPv4 over IPv6 for reliability in mixed environments.
        # IPv6 still works as fallback. See: man gai.conf, RFC 6724
        precedence ::ffff:0:0/96  100
    - unless: grep -q '^precedence.*::ffff:0:0/96.*100' /etc/gai.conf
