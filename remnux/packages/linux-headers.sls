{% set kernel = grains['kernelrelease'] %}

{% if "-WSL" in kernel %}

linux-headers-generic:
  pkg.installed

{% else %}

remnux-linux-headers:
  pkg.installed:
      - name: linux-headers-{{ kernel }}

{% endif %}
