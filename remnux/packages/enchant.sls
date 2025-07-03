remnux-packages-enchant:
  pkg.installed:
  {% if grains['oscodename'] == "focal" %}
    - name: enchant
  {% elif grains['oscodename'] == "noble" %}
    - name: enchant-2
  {% endif %}
