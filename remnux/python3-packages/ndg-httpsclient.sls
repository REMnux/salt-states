# Name: ndg-httpsclient
# Website: https://github.com/cedadev/ndg_httpsclient/
# Description: HTTPS client implementation for httplib and urllib2 based on PyOpenSSL.
# Category: 
# Author: Centre for Environmental Data Analysis Developers
# License: Copyright Science & Technology Facilities Council (https://github.com/cedadev/ndg_httpsclient/blob/master/ndg/httpsclient/LICENSE)
# Notes: 

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-ndg-httpsclient-venv:
  virtualenv.managed:
    - name: /opt/ndg-httpsclient
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib_metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-ndg-httpsclient:
  pip.installed:
    - name: ndg-httpsclient
    - bin_env: /opt/ndg-httpsclient/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-ndg-httpsclient-venv

remnux-python3-packages-ndg-httpsclient-symlink:
  file.symlink:
    - name: /usr/local/bin/ndg_httpclient
    - target: /opt/ndg-httpsclient/bin/ndg_httpclient
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-ndg-httpsclient
