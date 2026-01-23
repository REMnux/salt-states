# Name: REMnux Display Configuration
# Website: https://remnux.org/
# Description: VMware display fixes for Ubuntu 24.04 - forces X11, bypasses slow checks, adds set-scaling tool.
# Author: REMnux Project
# License: MIT License: https://github.com/REMnux/salt-states/blob/master/LICENSE
#
# Fixes VMware display issues on Ubuntu 24.04 (Noble)
# - Forces X11 (Wayland incompatible with VMware)
# - Bypasses slow GNOME acceleration checks
# - Disables slow accessibility services
# - Sets proper display scaling
#
# Once X11 is forced, the built-in vmware-user.desktop autostart
# handles dynamic resize, clipboard, and drag-drop automatically.

{% set set_scaling_hash = "3c7fae3fab4f443d1762d3e962c3325112b19ca135517ee5aeaf626f6fe7cfa7" %}

# ============================================================
# ENVIRONMENT VARIABLES (affects both X11 and Wayland sessions)
# ============================================================

# Fix Mutter black screen bug and disable slow accessibility
remnux-display-environment-vmware-fixes:
  file.append:
    - name: /etc/environment
    - text: |

        # VMware/GNOME fixes for REMnux
        MUTTER_DEBUG_FORCE_KMS_MODE=simple
        NO_AT_BRIDGE=1

# ============================================================
# GNOME ACCELERATION CHECK BYPASS (X11 and Wayland)
# ============================================================

# Bypass GNOME acceleration check (fixes 33-second GL timeout)
remnux-display-gnome-accel-check-bypass:
  file.managed:
    - name: /usr/libexec/gnome-session-check-accelerated
    - contents: |
        #!/bin/bash
        # Bypass acceleration check for VMware guest - immediate success
        exit 0
    - mode: 755

remnux-display-gnome-accel-gl-helper-bypass:
  file.managed:
    - name: /usr/libexec/gnome-session-check-accelerated-gl-helper
    - contents: |
        #!/bin/bash
        exit 0
    - mode: 755

remnux-display-gnome-accel-gles-helper-bypass:
  file.managed:
    - name: /usr/libexec/gnome-session-check-accelerated-gles-helper
    - contents: |
        #!/bin/bash
        exit 0
    - mode: 755

# ============================================================
# GDM CONFIGURATION (Force X11 instead of Wayland)
# ============================================================

# Force X11 for VMware compatibility
remnux-display-gdm-wayland-disable:
  file.replace:
    - name: /etc/gdm3/custom.conf
    - pattern: '#?WaylandEnable=.*'
    - repl: 'WaylandEnable=false'
    - append_if_not_found: True

remnux-display-gdm-default-session:
  file.replace:
    - name: /etc/gdm3/custom.conf
    - pattern: '#?DefaultSession=.*'
    - repl: 'DefaultSession=ubuntu-xorg.desktop'
    - append_if_not_found: True

# ============================================================
# VMWARE TOOLS CONFIGURATION
# ============================================================

# VMware tools display config
remnux-display-vmware-tools-display-config:
  file.append:
    - name: /etc/vmware-tools/tools.conf
    - text: |

        [resolutionKMS]
        enable = true

        [display]
        autofit = true

# ============================================================
# DISPLAY SCALING TOOL
# ============================================================

# User command for adjusting display scaling
remnux-display-set-scaling:
  file.managed:
    - name: /usr/local/bin/set-scaling
    - source: https://raw.githubusercontent.com/REMnux/distro/refs/heads/master/files/set-scaling
    - source_hash: sha256={{ set_scaling_hash }}
    - mode: 755

# ============================================================
# GNOME/DCONF SETTINGS (applies to GNOME sessions)
# ============================================================

# CRITICAL: Create dconf profile (without this, system settings are ignored!)
remnux-display-dconf-profile:
  file.managed:
    - name: /etc/dconf/profile/user
    - contents: |
        user-db:user
        system-db:local
    - makedirs: True

# Create dconf database directory
remnux-display-dconf-db-dir:
  file.directory:
    - name: /etc/dconf/db/local.d
    - makedirs: True

# Set display scaling to 1x by default (user can run set-scaling 2x for 4K)
remnux-display-dconf-display-settings:
  file.managed:
    - name: /etc/dconf/db/local.d/00-remnux-display
    - contents: |
        [org/gnome/desktop/interface]
        scaling-factor=uint32 1
        text-scaling-factor=1.0
        toolkit-accessibility=false
    - require:
      - file: remnux-display-dconf-db-dir

# Update dconf database
remnux-display-dconf-update:
  cmd.run:
    - name: dconf update
    - onchanges:
      - file: remnux-display-dconf-display-settings
      - file: remnux-display-dconf-profile
