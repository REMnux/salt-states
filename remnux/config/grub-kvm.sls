# Name: GRUB KVM Configuration
# Website: https://remnux.org/
# Description: Add nomodeset to GRUB for KVM/Proxmox display compatibility.
# Author: REMnux Project
# License: MIT License
#
# NOTE: nomodeset breaks VirtualBox auto-resize (tested 2025-01-24).
# Only apply on KVM/QEMU/Proxmox VMs, not Docker containers.
#
# Detection: We check for both KVM hypervisor AND absence of /.dockerenv
# because Docker Desktop on macOS/Windows reports virtual=kvm but the
# container has no GRUB (no /etc/default/grub file).

{% set hypervisor = grains.get('virtual', 'physical') %}
{% set in_docker = salt['file.file_exists']('/.dockerenv') %}

{% if hypervisor in ['kvm', 'QEMU', 'qemu'] and not in_docker %}

remnux-config-grub-kvm-nomodeset:
  file.replace:
    - name: /etc/default/grub
    - pattern: '^(GRUB_CMDLINE_LINUX_DEFAULT="[^"]*)"$'
    - repl: '\1 nomodeset"'
    - unless: grep -q 'nomodeset' /etc/default/grub
    - onlyif: test -f /etc/default/grub

remnux-config-grub-kvm-update:
  cmd.run:
    - name: update-grub
    - onchanges:
      - file: remnux-config-grub-kvm-nomodeset

{% else %}

# Non-KVM hypervisor or Docker container: no GRUB changes needed
remnux-config-grub-kvm-nop:
  test.nop

{% endif %}
