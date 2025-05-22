{% if grains['oscodename'] == 'noble' %}
  {% set package = 'libfuse2t64' %}
{% else %}
  {% set package = 'libfuse2' %}
{% endif %}

remnux-packages-libfuse2:
  pkg.installed:
    - name: {{ package }}
