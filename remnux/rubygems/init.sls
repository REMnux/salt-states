include:
  - remnux.rubygems.origamindee
  - remnux.rubygems.pdnstool
  - remnux.rubygems.pedump

remnux-rubygems:
  test.nop:
    - require:
      - sls: remnux.rubygems.origamindee
      - sls: remnux.rubygems.pdnstool
      - sls: remnux.rubygems.pedump
