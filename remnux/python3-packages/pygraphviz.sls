include:
  - remnux.packages.python3-pip
  - remnux.packages.libgraphviz-dev
  - remnux.packages.graphviz

remnux-python3-packages-pygraphviz:
  pip.installed:
    - name: pygraphviz == 1.6
    - bin_env: /usr/bin/python3
    - upgrade: True
    - install_options:
      - --include-path=/usr/include/graphviz
      - --library-path=/usr/lib/graphviz
    - require:
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.graphviz
      - sls: remnux.packages.libgraphviz-dev
