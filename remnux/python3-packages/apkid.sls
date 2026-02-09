# Name: APKiD
# Website: https://github.com/rednaga/APKiD
# Description: Identify compilers, packers, and obfuscators used to protect Android APK and DEX files.
# Category: Statically Analyze Code: Android
# Author: Caleb Fenton, Tim Strazzere: https://github.com/rednaga
# License: GNU General Public License v3.0: https://github.com/rednaga/APKiD/blob/master/LICENSE.GPL
# Notes: apkid

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-apkid-venv:
  virtualenv.managed:
    - name: /opt/apkid
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-apkid:
  pip.installed:
    - name: apkid
    - bin_env: /opt/apkid/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-apkid-venv

remnux-python3-packages-apkid-symlink:
  file.symlink:
    - name: /usr/local/bin/apkid
    - target: /opt/apkid/bin/apkid
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-apkid
