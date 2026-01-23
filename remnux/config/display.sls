# Name: REMnux Display Configuration
# Website: https://remnux.org/
# Description: Optional display enhancements for VMware guests.
# Author: REMnux Project
# License: MIT License: https://github.com/REMnux/salt-states/blob/master/LICENSE
#
# NOTE: Wayland works out of the box with kernel 6.8.0-90+ and open-vm-tools 12.5.0+.
# These are optional nice-to-haves, not required fixes.

{% set set_scaling_hash = "a8b726f7a501389e3052832b03e8c28603336d731e30237d12692dbb67cb319e" %}

# ============================================================
# DISPLAY SCALING TOOL (all versions)
# ============================================================

# User command for adjusting display scaling (1x/2x/3x/auto/detect)
remnux-display-set-scaling:
  file.managed:
    - name: /usr/local/bin/set-scaling
    - source: https://raw.githubusercontent.com/REMnux/distro/refs/heads/master/files/set-scaling
    - source_hash: sha256={{ set_scaling_hash }}
    - mode: 755

# ============================================================
# SCALING HINT (all versions)
# ============================================================

# Show scaling hint for first 3 terminal sessions
remnux-display-scaling-hint:
  file.append:
    - name: /etc/bash.bashrc
    - text: |

        # REMnux scaling hint - show first 3 terminal sessions
        _remnux_scaling_hint() {
            local counter_file="$HOME/.config/remnux/.scaling-hint-count"
            local max_shows=3
            [[ $- != *i* ]] && return
            mkdir -p "$(dirname "$counter_file")" 2>/dev/null
            local count=0
            [[ -f "$counter_file" ]] && count=$(<"$counter_file")
            if (( count < max_shows )); then
                echo -e "\n\033[1;36mTEXT TOO SMALL?\033[0m Run \033[1mset-scaling auto\033[0m or \033[1mset-scaling 2x\033[0m to adjust.\n"
                echo $(( count + 1 )) > "$counter_file"
            fi
        }
        _remnux_scaling_hint
        unset -f _remnux_scaling_hint

# ============================================================
# OPTIONAL ENVIRONMENT VARIABLES (Noble only)
# ============================================================

{% if grains['oscodename'] == "noble" %}

# Preventative fixes for edge cases on Ubuntu 24.04
remnux-display-environment:
  file.append:
    - name: /etc/environment
    - text: |

        # Optional VMware/GNOME enhancements for REMnux
        MUTTER_DEBUG_FORCE_KMS_MODE=simple
        NO_AT_BRIDGE=1

{% endif %}
