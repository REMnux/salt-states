include:
  - remnux.packages.libncurses5
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
      - pkg: python-virtualenv

rekall:
  pip.installed:
    - name: rekall
    - bin_env: /opt/rekall
    - require:
      - pip: pip
      - pip: wheel
      - pip: pip
      - pip: setuptools
      - pkg: libncurses5
      - virtualenv: rekall-virtualenv
