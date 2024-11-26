# Name: FakeNet-NG
# Website: https://github.com/mandiant/flare-fakenet-ng
# Description: Emulate common network services and interact with malware.
# Category: Explore Network Interactions: Services
# Author: FireEye Inc, Peter Kacherginsky, Michael Bailey: https://github.com/mandiant/flare-fakenet-ng/blob/master/AUTHORS
# License: Apache License 2.0: https://github.com/mandiant/flare-fakenet-ng/blob/master/LICENSE.txt
# Notes: Run the tool using `sudo fakenet`. First, edit `/opt/fakenet-ng/lib/python<py_version>/site-packages/fakenet/configs/default.ini`, changing the `LinuxRestrictInterface` parameter to your Ethernet network interface name, such as `ens33`.

{% set files = ['fakenet','ftpbench'] %}
include:
  - remnux.packages.python3-dev
  - remnux.packages.libssl-dev
  - remnux.packages.libffi-dev
  - remnux.packages.build-essential
  - remnux.packages.libnetfilter-queue-dev
  - remnux.packages.libnfnetlink-dev
  - remnux.packages.iptables
  - remnux.packages.git
  - remnux.packages.python3-virtualenv

remnux-python3-package-fakenet-ng-venv:
  virtualenv.managed:
    - name: /opt/fakenet-ng
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-fakenet-ng:
  pip.installed:
    - name: git+https://github.com/mandiant/flare-fakenet-ng.git
    - bin_env: /opt/fakenet-ng/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-fakenet-ng-venv
      - sls: remnux.packages.python3-dev
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.libffi-dev
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.libnetfilter-queue-dev
      - sls: remnux.packages.libnfnetlink-dev
      - sls: remnux.packages.iptables
      - sls: remnux.packages.git

{% for file in files %}
remnux-python3-package-fakenet-ng-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/fakenet-ng/bin/{{ file }}
    - makedirs: False
    - require:
      - pip: remnux-python3-package-fakenet-ng
{% endfor %}
