# Name: GRUB KVM Configuration
# Website: https://remnux.org/
# Description: Add nomodeset to GRUB for KVM/Proxmox display compatibility.
# Author: REMnux Project
# License: MIT License
#
# NOTE: nomodeset breaks VirtualBox auto-resize (tested 2025-01-24).
# Only apply on KVM/QEMU/Proxmox VMs that have GRUB installed.
# Containers (Docker, Podman, LXC) don't have GRUB - skip them.

{% set hypervisor = grains.get('virtual', 'physical') %}
{% set has_grub = salt['file.file_exists']('/etc/default/grub') %}

{% if hypervisor in ['kvm', 'QEMU', 'qemu'] and has_grub %}

remnux-config-grub-kvm-nomodeset:
  file.replace:
    - name: /etc/default/grub
    - pattern: '^(GRUB_CMDLINE_LINUX_DEFAULT="[^"]*)"$'
    - repl: '\1 nomodeset"'
    - unless: grep -q 'nomodeset' /etc/default/grub

remnux-config-grub-kvm-update:
  cmd.run:
    - name: update-grub
    - onchanges:
      - file: remnux-config-grub-kvm-nomodeset

{% else %}

# Non-KVM hypervisor or no GRUB installed: skip
remnux-config-grub-kvm-nop:
  test.nop

{% endif %}
