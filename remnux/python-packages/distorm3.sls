{%- if grains['oscodename'] == "bionic" %}
include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip

# distorm3 v3.5.0 breaks Volatility 2.6.1, so we're installing distorm3 v3.4.4
distorm3==3.4.4:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip

{%- elif grains['oscodename'] == "focal" %}
include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip
  - remnux.packages.python2-dev

distorm3==3.4.4:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.python2-dev

{%- endif %}
