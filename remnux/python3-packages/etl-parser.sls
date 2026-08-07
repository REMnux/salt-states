# Name: etl-parser
# Website: https://github.com/airbus-cert/etl-parser
# Description: Parse Windows Event Trace Log (ETL) files.
# Category: Gather and Analyze Data
# Author: Airbus CERT: https://github.com/airbus-cert
# License: Apache License 2.0: https://github.com/airbus-cert/etl-parser/blob/main/LICENSE
# Notes: Convert a trace to XML with `etl2xml -i input.etl -o output.xml`. REMnux adds a schema so that AMSI traces captured with `logman` decode as well.

{% set files = ['etl2xml','etl2pcap'] %}
{% set commit = 'e9ad559f8ba2cd192a1c6be2011f514dad46c3a2' %}
{% set patch = '/usr/local/src/remnux/files/etl-parser-amsi-1101-v1.py' %}
{% set module = '/opt/etl-parser/lib/python3*/site-packages/etl/parsers/etw/Microsoft_Antimalware_Scan_Interface.py' %}

include:
  - remnux.packages.git
  - remnux.packages.python3-virtualenv

remnux-python3-package-etl-parser-venv:
  virtualenv.managed:
    - name: /opt/etl-parser
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: remnux.packages.python3-virtualenv

remnux-python3-package-etl-parser:
  pip.installed:
    - name: git+https://github.com/airbus-cert/etl-parser.git@{{ commit }}
    - bin_env: /opt/etl-parser/bin/python3
    - upgrade: True
    - require:
      - virtualenv: remnux-python3-package-etl-parser-venv
      - sls: remnux.packages.git

# The project declares AMSI event 1101 at version 0 only. Current Windows emits
# version 1 with the same structure, so AMSI traces are skipped with the message
# "No class handle this ETW provider ... for event id : (1101) for version : 1"
# and etl2xml returns a document with no events. Register the same pattern for
# version 1. Drop the two states below once the project registers it upstream.
remnux-python3-package-etl-parser-amsi-source:
  file.managed:
    - name: {{ patch }}
    - makedirs: True
    - mode: 644
    - contents: |
        @declare(guid=guid("2a576b87-09a7-520e-c21a-4942f0271d67"), event_id=1101, version=1)
        class Microsoft_Antimalware_Scan_Interface_1101_1(Etw):
            pattern = Struct(
                "session" / Int64ul,
                "scanStatus" / Int8ul,
                "scanResult" / Int32ul,
                "appname" / WString,
                "contentname" / WString,
                "contentsize" / Int32ul,
                "originalsize" / Int32ul,
                "content" / Bytes(lambda this: this.contentsize),
                "hash" / Bytes(16),
                "contentFiltered" / Int8ul
            )

# The guard asks the library whether version 1 is registered rather than matching
# source text, so this becomes a no-op if the project adds it in any form.
remnux-python3-package-etl-parser-amsi-1101-v1:
  cmd.run:
    - name: F=$(ls {{ module }}) && printf '\n\n' >> "$F" && cat {{ patch }} >> "$F" && find /opt/etl-parser -name __pycache__ -prune -exec rm -rf {} +
    - unless: /opt/etl-parser/bin/python3 -c "import etl.parsers.etw.Microsoft_Antimalware_Scan_Interface; from etl.parsers.etw.core import __etw_factory__, guid; raise SystemExit(0 if 1 in __etw_factory__.get(guid('2a576b87-09a7-520e-c21a-4942f0271d67'), {}).get(1101, {}) else 1)"
    - require:
      - pip: remnux-python3-package-etl-parser
      - file: remnux-python3-package-etl-parser-amsi-source

{% for file in files %}
remnux-python3-package-etl-parser-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/etl-parser/bin/{{ file }}
    - makedirs: False
    - force: True
    - require:
      - cmd: remnux-python3-package-etl-parser-amsi-1101-v1
{% endfor %}
