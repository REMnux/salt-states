include:
  - remnux.packages.python2
  - remnux.packages.curl

{%- if grains['oscodename'] == "bionic" %}
remnux-packages-python2-pip:
  pkg.installed:
    - name: python-pip
    - require:
      - sls: remnux.packages.python2

{%- elif grains['oscodename'] == "focal" %}
remnux-packages-python2-pip-install-script:
  cmd.run:
    - name: curl -o /tmp/get-pip.py https://bootstrap.pypa.io/2.7/get-pip.py 
    - unless: which pip2
    - require:
      - sls: remnux.packages.python2
      - sls: remnux.packages.curl

remnux-packages-python2-pip-install:
  cmd.run:
    - name: python2 /tmp/get-pip.py
    - unless: which pip2
    - require:
      - cmd: remnux-packages-python2-pip-install-script
{%- endif %}
