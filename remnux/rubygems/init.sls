include:
  - remnux.rubygems.origami
  - remnux.rubygems.pdnstool
  - remnux.rubygems.pedump

remnux-rubygems:
  test.nop:
    - require:
      - sls: remnux.rubygems.origami
      - sls: remnux.rubygems.pdnstool
      - sls: remnux.rubygems.pedump
