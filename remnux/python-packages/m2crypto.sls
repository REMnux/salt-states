{%- if grains['oscodename'] == "bionic" %}
include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip
  - remnux.packages.swig
  - remnux.packages.libssl-dev

remnux-python-packages-m2crypto:
  pip.installed:
    - name: m2crypto
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.swig
      - sls: remnux.packages.libssl-dev

{%- elif grains['oscodename'] == "focal" %}
include:
  - remnux.packages.python2-pip
  - remnux.packages.python3-pip
  - remnux.packages.swig
  - remnux.packages.libssl-dev
  - remnux.packages.python2-dev

remnux-python-packages-m2crypto:
  pip.installed:
    - name: m2crypto
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: remnux.packages.python2-pip
      - sls: remnux.packages.swig
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.python2-dev

{%- endif %}

