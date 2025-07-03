remnux-packages-libglib2:
  pkg.installed:
    {% if grains['oscodename'] != 'noble' %}
    - name: libglib2.0-0
    {% else %}
    - name: libglib2.0-0t64
    {% endif %}
