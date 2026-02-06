# Name: Hypervisor-Aware Guest Tools
# Website: https://remnux.org/
# Description: Install appropriate guest tools based on detected hypervisor.
# Author: REMnux Project
# License: MIT License

{% set hypervisor = grains.get('virtual', 'physical') %}

{% if hypervisor in ['VMware', 'vmware'] %}

open-vm-tools-desktop:
  pkg.installed

{% elif hypervisor in ['kvm', 'QEMU', 'qemu'] %}

qemu-guest-agent:
  pkg.installed

spice-vdagent:
  pkg.installed

# Only enable service if not in container (Docker detection)
{% if grains.get('virtual_subtype', '') != 'Docker' %}
# Check if virtio serial port exists (required for qemu-guest-agent communication)
{% set virtio_device = '/dev/virtio-ports/org.qemu.guest_agent.0' %}
{% if salt['file.file_exists'](virtio_device) %}
remnux-qemu-guest-agent-service:
  service.running:
    - name: qemu-guest-agent
    - enable: True
    - require:
      - pkg: qemu-guest-agent
{% else %}
# Virtio serial device missing - hypervisor not configured for guest agent
remnux-qemu-guest-agent-notice:
  test.show_notification:
    - text: "qemu-guest-agent installed but service not started (virtio serial device missing). To enable: Proxmox - enable 'QEMU Guest Agent' in VM Options; libvirt - add virtio-serial device with guest agent channel. Restart VM and re-run install."
{% endif %}
{% endif %}

{% elif hypervisor in ['VirtualBox', 'virtualbox'] %}

# VirtualBox: Install nothing - user installs Guest Additions from ISO
# Ubuntu virtualbox-guest-* packages lack full functionality (tested 2025-01-24)
remnux-guest-tools-virtualbox-nop:
  test.nop

{% else %}

# Fallback for Hyper-V, bare metal, or unknown hypervisors
open-vm-tools-desktop:
  pkg.installed

{% endif %}
