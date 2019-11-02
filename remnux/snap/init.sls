include:
  - remnux.snap.pdftk

remnux-snap:
  test.nop:
    - require:
      - sls: remnux.snap.pdftk
