include:
  - remnux.python-packages.pip
  - remnux.packages.graphviz-dev
  - remnux.packages.graphviz

remnux-pygraphviz:
  pip.installed:
    - name: pygraphviz
    - install_options:
      - --include-path=/usr/include/graphviz
      - --library-path=/usr/lib/graphviz
    - require:
      - pkg: graphviz-dev
      - pkg: graphviz
      - pip: pip
