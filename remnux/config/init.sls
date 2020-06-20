include:
  - remnux.config.user
  - remnux.config.inetsim
  - remnux.config.wget
  - remnux.config.curl
  - remnux.config.objects
  - remnux.config.bash-rc
  - remnux.config.bash-history
  - remnux.config.thug
  - remnux.config.networkminer
  - remnux.config.salt-minion
  - remnux.config.dot-local
  - remnux.config.dot-cache
  - remnux.config.ghidra
  - remnux.config.bash-completion

remnux-config:
  test.nop:
    - require:
      - sls: remnux.config.user
      - sls: remnux.config.inetsim
      - sls: remnux.config.wget
      - sls: remnux.config.curl
      - sls: remnux.config.objects
      - sls: remnux.config.bash-rc
      - sls: remnux.config.bash-history
      - sls: remnux.config.thug
      - sls: remnux.config.networkminer
      - sls: remnux.config.salt-minion
      - sls: remnux.config.dot-local
      - sls: remnux.config.dot-cache
      - sls: remnux.config.ghidra
      - sls: remnux.config.bash-completion