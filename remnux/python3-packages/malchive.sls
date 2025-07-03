# Name: Malchive
# Website: https://github.com/MITRECND/malchive
# Description: Perform static analysis of various aspects of malicious code.
# Category: Statically Analyze Code: PE Files, Examine Static Properties: Deobfuscation
# Author: The MITRE Corporation, https://github.com/MITRECND/malchive/graphs/contributors
# License: Apache License 2.0: https://github.com/MITRECND/malchive/blob/main/LICENSE
# Notes: Malchive command-line tools start with the prefix `malutil-`. See [utilities documentation](https://github.com/MITRECND/malchive/wiki/Utilities) for details.
{% set tools = [
                'maldec-apollo','maldisc-cobaltstrike_beacon','malutil-aplibdumper','malutil-dotnetdumper','malutil-hashes','malutil-peresources','malutil-superstrings',
                'maldec-cobaltstrike_payload','maldisc-meterpreter_reverse_shell','malutil-b64dump','malutil-entropycalc','malutil-hiddencab','malutil-petimestamp','malutil-vtinspect',
                'maldec-pivy','maldisc-shadowpad','malutil-brute_xor','malutil-findapihash','malutil-killaslr','malutil-reverse_bytes','malutil-xor',
                'maldec-rzstreet_dumper','maldisc-spivy','malutil-byteflip','malutil-genrsa','malutil-negate','malutil-rotate','malutil-xor-pairwise',
                'maldec-sunburst','malutil-add','malutil-cobaltstrike_malleable_restore','malutil-gensig','malutil-pecarver','malutil-ssl_cert',
                'maldec-sunburst_dga','malutil-apihash','malutil-comguidtoyara','malutil-guid_recovery','malutil-pepdb','malutil-sub'
] %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.git
  - remnux.packages.libsqlite3-dev
  - remnux.python3-packages.cffi

remnux-python3-packages-malchive-venv:
  virtualenv.managed:
    - name: /opt/malchive
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-packages-malchive:
  pip.installed:
    - name: git+https://github.com/MITRECND/malchive.git@ec0f355ceaef0e1311ad3e079d9512f95a341c32
    - branch: main
    - bin_env: /opt/malchive/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-packages-malchive-venv
      - sls: remnux.packages.git
      - sls: remnux.packages.libsqlite3-dev
      - sls: remnux.python3-packages.cffi

{% for tool in tools %}
remnux-python3-packages-malchive-symlink-{{ tool }}:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/malchive/bin/{{ tool }}
    - force: True
    - makedirs: False
    - require:
      - pip: remnux-python3-packages-malchive
{% endfor %}
