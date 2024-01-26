libssl-dev:
  pkg.installed

libssl-ldconfig:
  cmd.run:
    - name: ldconfig /usr/local/lib64/
    - require:
      - pkg: libssl-dev

