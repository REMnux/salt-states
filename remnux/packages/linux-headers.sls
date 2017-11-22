remnux-linux-headers:
  pkg.installed:
      - name: linux-headers-{{ grains['kernelrelease'] }}
