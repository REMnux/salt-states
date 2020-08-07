# Name: Viper
# Website: https://github.com/viper-framework/viper
# Description: Organize and query a collection of malware samples.
# Category: Gather and Analyze Data
# Author: Claudio Guarnieri: https://nex.sx
# License: BSD 3-Clause License: https://github.com/viper-framework/viper/blob/master/LICENSE
# Notes: viper

{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}

{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = "/home/" + user -%}
{% endif %}

include:
  - remnux.config.user
  - remnux.packages.libssl-dev
  - remnux.packages.swig
  - remnux.packages.libusb-1
  - remnux.packages.libfuzzy-dev
  - remnux.packages.git
  - remnux.packages.virtualenv
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.python3-virtualenv
  - remnux.packages.python3-venv
  - remnux.packages.build-essential
  - remnux.packages.libffi-dev
  - remnux.packages.unrar
  - remnux.packages.p7zip-full
  - remnux.packages.tor
  - remnux.packages.clamav-daemon
  - remnux.packages.ssdeep
  - remnux.packages.libdpkg-perl
  - remnux.perl-packages.exiftool

remnux-python-packages-viper-virtualenv:
  virtualenv.managed:
    - name: /opt/viper
    - venv_bin: /usr/bin/virtualenv
    - python: /usr/bin/python3
    - pip_pkgs:
      - pip
      - setuptools
      - wheel
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.python3-venv
      - sls: remnux.packages.virtualenv

remnux-python-packages-viper-install:
  pip.installed:
    - name: viper-framework
    - bin_env: /opt/viper/bin/python3
    - require:
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.swig
      - sls: remnux.packages.libusb-1
      - sls: remnux.packages.libfuzzy-dev
      - sls: remnux.packages.git
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.libffi-dev
      - sls: remnux.packages.unrar
      - sls: remnux.packages.p7zip-full
      - sls: remnux.packages.tor
      - sls: remnux.packages.clamav-daemon
      - sls: remnux.packages.ssdeep
      - sls: remnux.packages.libdpkg-perl
      - sls: remnux.perl-packages.exiftool
      - virtualenv: remnux-python-packages-viper-virtualenv

remnux-python-packages-viper-update-fix:
  file.replace:
    - name: /opt/viper/lib/python3.6/site-packages/viper/core/ui/cmd/update-modules.py
    - pattern: '"pip3", "install"'
    - repl: '"/opt/viper/bin/pip3", "install"'
    - count: 1
    - prepend_if_not_found: False
    - require:
      - pip: remnux-python-packages-viper-install

remnux-python-packages-viper-directory:
  file.directory:
    - name: {{ home }}/.viper
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - recurse:
      - user
      - group
    - require:
      - pip: remnux-python-packages-viper-install
      - user: remnux-user-{{ user }}

remnux-python-packages-viper-modules-git:
  git.cloned:
    - name: https://github.com/viper-framework/viper-modules.git
    - target: {{ home }}/.viper/modules
    - user: {{ user }}
    - require:
      - file: remnux-python-packages-viper-directory

remnux-python-packages-viper-modules-verify-sigs:
  file.replace:
    - name: {{ home }}/.viper/modules/requirements.txt
    - pattern: 'verify-sigs @ '
    - repl: ''
    - count: 1
    - prepend_if_not_found: False
    - require:
      - git: remnux-python-packages-viper-modules-git

remnux-python-packages-viper-modules-pymispgalaxies:
  file.replace:
    - name: {{ home }}/.viper/modules/requirements.txt
    - pattern: 'PyMISPGalaxies @ '
    - repl: ''
    - count: 1
    - prepend_if_not_found: False
    - require:
      - git: remnux-python-packages-viper-modules-git

remnux-python-packages-viper-modules-init:
  cmd.run:
    - name: git submodule init
    - cwd: {{ home }}/.viper/modules
    - require:
      - git: remnux-python-packages-viper-modules-git

remnux-python-packages-viper-modules-update:
  cmd.run:
    - name: git submodule update
    - cwd: {{ home }}/.viper/modules
    - require:
      - git: remnux-python-packages-viper-modules-git

remnux-python-packages-viper-modules-requirements:
  pip.installed:
    - requirements: {{ home }}/.viper/modules/requirements.txt
    - upgrade: True
    - bin_env: /opt/viper/bin/pip3
    - require:
      - file: remnux-python-packages-viper-modules-verify-sigs
      - file: remnux-python-packages-viper-modules-pymispgalaxies

remnux-python-packages-viper-symlink:
  file.symlink:
    - name: /usr/local/bin/viper
    - target: /opt/viper/bin/viper
    - force: true
    - require:
      - pip: remnux-python-packages-viper-install

remnux-python-packages-viper-venv-directory:
  file.directory:
    - name: /opt/viper
    - makedirs: False
    - user: {{ user }}
    - group: {{ user }}
    - recurse:
      - user
      - group
    - require:
      - pip: remnux-python-packages-viper-install
