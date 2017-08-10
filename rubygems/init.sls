include:
  - remnux.rubygems.origami
  - remnux.rubygems.passivedns-client
  - remnux.rubygems.pedump
  - remnux.rubygems.therubyracer

remnux-rubygems:
  test.nop:
    - require:
      - sls: remnux.rubygems.origami
      - sls: remnux.rubygems.passivedns-client
      - sls: remnux.rubygems.pedump
      - sls: remnux.rubygems.therubyracer
