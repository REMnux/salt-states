{# remnux/osarch.sls #}
{% if grains['osarch'] in ['amd64', 'x86_64'] %}
  {% set osarch = 'amd64' %}
{% elif grains['osarch'] in ['arm64', 'aarch64'] %}
  {% set osarch = 'arm64' %}
{% endif %}
