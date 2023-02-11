{% if grains['oscodename'] == "focal" %}

libre2-5:
  pkg.installed

{% elif grains['oscodename'] == "bionic" %}

libre2-4:
  pkg.installed

{% endif %}
