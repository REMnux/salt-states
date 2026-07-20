# Name: Lyrebird
# Website: https://github.com/cac0ns3c/Lyrebird
# Description: Emulate internet services (HTTP, DNS, SMTP, IRC, and more) to keep detonating malware talking while capturing every interaction as structured JSONL; a modern successor to INetSim with first-class detection telemetry.
# Category: Explore Network Interactions: Services
# Author: Lyrebird contributors: https://github.com/cac0ns3c/Lyrebird/graphs/contributors
# License: GPL-3.0-or-later: https://github.com/cac0ns3c/Lyrebird/blob/main/LICENSE
# Notes: Run the tool using `lyrebird` (built-in defaults apply) or point it at a config with `lyrebird --config /path/to/lyrebird.yaml`. A sample config lives at config/lyrebird.yaml in the project repository.

include:
  - remnux.packages.python3-virtualenv

remnux-python3-packages-lyrebird-venv:
  virtualenv.managed:
    - name: /opt/lyrebird
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=77.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-lyrebird:
  pip.installed:
    - name: lyrebird-emulator
    - bin_env: /opt/lyrebird/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-lyrebird-venv

remnux-python3-packages-lyrebird-symlink:
  file.symlink:
    - name: /usr/local/bin/lyrebird
    - target: /opt/lyrebird/bin/lyrebird
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-lyrebird
