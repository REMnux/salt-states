# Name: FLOSS
# Website: https://github.com/mandiant/flare-floss
# Description: Extract and deobfuscate strings from PE executables.
# Category: Examine Static Properties: Deobfuscation
# Author: Mandiant, Willi Ballenthin: https://x.com/williballenthin, Moritz Raabe
# License: Apache License 2.0: https://github.com/mandiant/flare-floss/blob/master/LICENSE.txt
# Notes: floss

{# FLOSS installs from PyPI on every architecture. The REMnux PPA's flare-floss package wraps an x86-64 binary. #}
{# The PPA package is removed only after the PyPI install succeeds, so a failed upgrade keeps the working copy. #}
{% set version = '3.1.1' %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-dev
  - remnux.packages.build-essential

remnux-python3-packages-flare-floss-virtualenv:
  virtualenv.managed:
    - name: /opt/flare-floss
    - venv_bin: /usr/bin/virtualenv
    - python: /usr/bin/python3
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-flare-floss:
  pip.installed:
    - name: flare-floss=={{ version }}
    - bin_env: /opt/flare-floss/bin/python3
    - require:
      - virtualenv: remnux-python3-packages-flare-floss-virtualenv
      - sls: remnux.packages.python3-dev
      - sls: remnux.packages.build-essential

remnux-python3-packages-flare-floss-symlink:
  file.symlink:
    - name: /usr/local/bin/floss
    - target: /opt/flare-floss/bin/floss
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-flare-floss

remnux-python3-packages-flare-floss-remove-ppa-package:
  pkg.removed:
    - name: flare-floss
    - require:
      - file: remnux-python3-packages-flare-floss-symlink

{# Keep /usr/bin/floss working for scripts that call it by full path, as the PPA package installed it there. #}
remnux-python3-packages-flare-floss-usr-bin-symlink:
  file.symlink:
    - name: /usr/bin/floss
    - target: /opt/flare-floss/bin/floss
    - force: True
    - makedirs: False
    - require:
      - pkg: remnux-python3-packages-flare-floss-remove-ppa-package
