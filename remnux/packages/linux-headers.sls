{% set kernel = grains['kernelrelease'] %}

{% if "-WSL" in kernel or "-linuxkit" in kernel %}

linux-headers-generic:
  pkg.installed

{% else %}

remnux-packages-linux-headers:
  pkg.installed:
      - name: linux-headers-{{ kernel }}

{% endif %}
