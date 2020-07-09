# Name: pdfobjflow
# Website: https://bitbucket.org/sebastiendamaye/pdfobjflow
# Description: Create a map of object flows of a PDF file.
# Category: Analyze Documents: PDF
# Author: Sebastien Damaye
# License: Free, unknown license
# Notes: 

{%- set commit = "543c830b416244cfea3d70be5aface73bba66cc0" %}
{%- set hash   = "059374f82a20107fa75f1f25f96cb3d24e9e53e98294c860496a810bae8e7b7d" %}

include:
  - remnux.packages.python-pydot
  - remnux.scripts.pdf-parser

remnux-scripts-pdfobjflow:
  file.managed:
    - name: /usr/local/bin/pdfobjflow.py
    - source: https://bitbucket.org/sebastiendamaye/pdfobjflow/raw/{{ commit }}/pdfobjflow.py
    - source_hash: sha256={{ hash }}
    - mode: 755
    - require:
      - sls: remnux.packages.python-pydot
      - sls: remnux.scripts.pdf-parser