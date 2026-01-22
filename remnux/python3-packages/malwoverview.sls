# Name: malwoverview
# Website: https://github.com/alexandreborges/malwoverview
# Description: Query public repositories of malware data (e.g., VirusTotal, HybridAnalysis).
# Category: Gather and Analyze Data
# Author: Alexandre Borges
# License: GNU General Public License v3: https://github.com/alexandreborges/malwoverview/blob/master/LICENSE
# Notes: malwoverview, add API keys to ~/.malwapi.conf

{%- set user = salt['pillar.get']('remnux_user', 'remnux') -%}       

{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - remnux.packages.git
  - remnux.config.user
  - remnux.packages.python3-virtualenv
  - remnux.packages.build-essential
  - remnux.packages.libmagic-dev

remnux-python3-packages-malwoverview-virtualenv:
  virtualenv.managed:
    - name: /opt/malwoverview
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib_metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-malwoverview-install:
  pip.installed:
    - name: malwoverview
    - bin_env: /opt/malwoverview/bin/python3
    - upgrade: True
    - user: root
    - require:
      - virtualenv: remnux-python3-packages-malwoverview-virtualenv
      - sls: remnux.packages.git
      - sls: remnux.config.user
      - sls: remnux.packages.libmagic-dev

remnux-python3-packages-malwoverview-config-file:
  file.managed:
    - name: {{ home }}/.malwapi.conf
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: False
    - contents: |
        [VIRUSTOTAL]
        VTAPI =

        [HYBRID-ANALYSIS]
        HAAPI =

        [MALSHARE]
        MALSHAREAPI =

        [POLYSWARM]
        POLYAPI =

        [ALIENVAULT]
        ALIENAPI =

        [MALPEDIA]
        MALPEDIAAPI =

        [TRIAGE]
        TRIAGEAPI =

        [INQUEST]
        INQUESTAPI =

        [VIRUSEXCHANGE]
        VXAPI =

        [IPINFO]
        IPINFOAPI =

        [BAZAAR]
        BAZAARAPI =

        [THREATFOX]
        THREATFOXAPI =

        [URLHAUS]
        URLHAUSAPI =
    - require:
      - sls: remnux.config.user
      - user: remnux-user-{{ user }}
      - pip: remnux-python3-packages-malwoverview-install
      - virtualenv: remnux-python3-packages-malwoverview-virtualenv

remnux-python3-packages-malwoverview-symlink:
  file.symlink:
    - name: /usr/local/bin/malwoverview
    - target: /opt/malwoverview/bin/malwoverview
    - force: true
    - require:
      - file: remnux-python3-packages-malwoverview-config-file
