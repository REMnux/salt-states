remnux-packages-libre2:
  pkg.installed:
{% if grains['oscodename'] == "focal" %}
    - name: libre2-5
{% elif grains['oscodename'] == "noble" %}
    - name: libre2-10
{% endif %}
