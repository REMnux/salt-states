include:
  - remnux.packages.python-pip
  - remnux.packages.python3-pip
  - remnux.packages.libncurses

remnux-rekall-requirements:
  pip.installed:
    - names: 
      - future==0.16.0
      - pyaff4==0.26.post6
      - pybindgen
      - capstone
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.libncurses
      - sls: remnux.packages.python3-pip

remnux-rekall-install:
  pip.installed:
    - names:
      - rekall
      - rekall-agent
    - bin_env: /usr/bin/python3
    - require:
      - sls: remnux.packages.python3-pip
      - pip: remnux-rekall-requirements
    - watch:
      - pip: remnux-rekall-requirements
