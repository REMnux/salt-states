include:
  - remnux.packages.libncurses
  - remnux.packages.python-virtualenv
  - .pip
  - .setuptools
  - .wheel

rekall-virtualenv:
  virtualenv.managed:
    - name: /opt/rekall
    - pip_pkgs:
      - pip
      - setuptools
      - wheel
      - rekall
    - require:
      - sls: remnux.packages.python-virtualenv

rekall:
  pip.installed:
    - name: rekall
    - bin_env: /opt/rekall
    - require:
      - pip: pip
      - pip: wheel
      - pip: pip
      - pip: setuptools
      - sls: remnux.packages.libncurses
      - virtualenv: rekall-virtualenv
