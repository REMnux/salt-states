# Name: GRUB nomodeset Cleanup
# Website: https://remnux.org/
# Description: Remove the legacy 'nomodeset' kernel parameter that older REMnux
#   builds and appliance images added for KVM/QEMU SPICE display. On modern
#   kernels the in-kernel qxl/virtio-gpu driver handles the display, and
#   'nomodeset' instead caps the console at 640x480 by forcing the generic
#   simpledrm framebuffer.
# Author: REMnux Project
# License: MIT License
#
# Behavior:
#   - Surgical: removes only the 'nomodeset' token, leaving any other kernel
#     parameters the user set in place.
#   - One-time: runs once per system, guarded by the sentinel
#     /var/lib/remnux/nomodeset-cleaned. A user who later sets 'nomodeset' on
#     purpose for their own hardware is never overridden.
#   - Self-healing: clears 'nomodeset' from already-shipped appliance images on
#     the next 'remnux install' or update. No-op on systems that never had it.
#   - Containers (no /etc/default/grub) are skipped.

{% set sentinel = '/var/lib/remnux/nomodeset-cleaned' %}
{% set has_grub = salt['file.file_exists']('/etc/default/grub') %}
{% set already_done = salt['file.file_exists'](sentinel) %}

# Anchor: always declare at least one state so init.sls's
# `require: - sls: remnux.config.grub-nomodeset-cleanup` always resolves. Without
# this, on an already-cleaned system (sentinel present) or a container (no
# /etc/default/grub) the block below renders to zero states and the requisite
# fails with "The following requisites were not found".
remnux-config-grub-nomodeset-cleanup:
  test.nop: []

{% if has_grub and not already_done %}

# Strip the 'nomodeset' token (and a single leading space if present) wherever it
# appears in /etc/default/grub. In practice that is only GRUB_CMDLINE_LINUX_DEFAULT.
remnux-config-grub-remove-nomodeset:
  file.replace:
    - name: /etc/default/grub
    - pattern: ' *\bnomodeset\b'
    - repl: ''
    - backup: False

# Regenerate grub.cfg only when the line above actually changed.
remnux-config-grub-update:
  cmd.run:
    - name: update-grub
    - onchanges:
      - file: remnux-config-grub-remove-nomodeset

# Marker directory for REMnux one-time, system-level state.
remnux-config-grub-nomodeset-sentinel-dir:
  file.directory:
    - name: /var/lib/remnux
    - makedirs: True

# Drop the sentinel so this cleanup never touches GRUB again, even if the user
# later adds 'nomodeset' deliberately. Written after a successful replace pass.
remnux-config-grub-nomodeset-sentinel:
  file.managed:
    - name: {{ sentinel }}
    - contents: |
        REMnux removed the legacy nomodeset kernel parameter on first install.
        Delete this file to let the cleanup run again.
    - require:
      - file: remnux-config-grub-remove-nomodeset
      - file: remnux-config-grub-nomodeset-sentinel-dir

{% endif %}
