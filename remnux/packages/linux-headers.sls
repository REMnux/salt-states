{% set kernel = grains['kernelrelease'] %}

{% if "-WSL" or "-linuxkit" in kernel %}

linux-headers-generic:
  pkg.installed

{% else %}

remnux-packages-linux-headers:
  pkg.installed:
      - name: linux-headers-{{ kernel }}

{% endif %}
