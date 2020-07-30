include:
  - remnux.packages.python-pip
  - remnux.packages.libgraphviz-dev
  - remnux.packages.graphviz
  - remnux.packages.python3-pip

remnux-pygraphviz:
  pip.installed:
    - bin_env: /usr/bin/python
    - name: pygraphviz
    - install_options:
      - --include-path=/usr/include/graphviz
      - --library-path=/usr/lib/graphviz
    - require:
      - pkg: libgraphviz-dev
      - pkg: graphviz
      - sls: remnux.packages.python-pip
