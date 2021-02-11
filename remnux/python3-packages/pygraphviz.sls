include:
  - remnux.python3-packages.pip
  - remnux.packages.libgraphviz-dev
  - remnux.packages.graphviz

remnux-python3-packages-pygraphviz:
  pip.installed:
    - name: pygraphviz
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.python3-packages.pip
      - sls: remnux.packages.graphviz
      - sls: remnux.packages.libgraphviz-dev
