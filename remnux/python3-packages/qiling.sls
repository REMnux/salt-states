# Name: Qiling
# Website: https://www.qiling.io
# Description: Emulate code execution of PE files, shellcode, etc. for a variety of OS and hardware platforms.
# Category: Statically Analyze Code: General, Dynamically Reverse-Engineer Code: Shellcode
# Author: https://github.com/qilingframework/qiling/blob/master/AUTHORS.TXT
# License: GNU General Public License (GPL) v2.0: https://github.com/qilingframework/qiling/blob/master/COPYING
# Notes: Use `qltool` to analyze artifacts. Before analyzing Windows artifacts, gather Windows DLLs and other components using the [dllscollector.bat](https://github.com/qilingframework/qiling/blob/master/examples/scripts/dllscollector.bat) script. Read the tool's [documentation](https://docs.qiling.io) to get started.

{% from "remnux/osarch.sls" import osarch with context %}

include:
  - remnux.packages.python3-virtualenv

{% if osarch == "arm64" %}
{# keystone-engine has no arm64 wheel, so pip compiles it, which needs cmake and a compiler #}
remnux-python3-packages-qiling-build-deps:
  pkg.installed:
    - pkgs:
      - cmake
      - build-essential
      - python3-dev
{% endif %}

remnux-python3-packages-qiling-virtualenv:
  virtualenv.managed:
    - name: /opt/qiling
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib_metadata>=8.0.0
      - pyyaml
      - six
    - require:
      - sls: remnux.packages.python3-virtualenv

{% if osarch == "arm64" %}
{# keystone-engine has no arm64 wheel. pip compiles it, and pip's isolated build environment breaks that build #}
{# (missing stdlib modules), so it is installed on its own without build isolation before qiling. #}
remnux-python3-packages-qiling-keystone:
  pip.installed:
    - name: keystone-engine
    - bin_env: /opt/qiling/bin/python3
    - extra_args:
      - --no-build-isolation
    - require:
      - virtualenv: remnux-python3-packages-qiling-virtualenv
      - pkg: remnux-python3-packages-qiling-build-deps
{% endif %}

remnux-python3-packages-qiling:
  pip.installed:
    - name: qiling
    - bin_env: /opt/qiling/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-qiling-virtualenv
{% if osarch == "arm64" %}
      - pip: remnux-python3-packages-qiling-keystone
{% endif %}

remnux-python3-packages-qiling-symlink:
  file.symlink:
    - name: /usr/local/bin/qltool
    - target: /opt/qiling/bin/qltool
    - makedirs: False
    - force: True
    - require:
      - pip: remnux-python3-packages-qiling
