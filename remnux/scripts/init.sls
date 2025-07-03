include:
  - remnux.scripts.java-idx-parser
  - remnux.scripts.ex-pe-xor
  - remnux.scripts.extract-swf
  - remnux.scripts.nomorexor
  - remnux.scripts.strdeob
  - remnux.scripts.pyinstaller-extractor
  - remnux.scripts.hash-identifier
  - remnux.scripts.dexray
  - remnux.scripts.accept-all-ips
  - remnux.scripts.myip
  - remnux.scripts.mynic
  - remnux.scripts.anomy
  - remnux.scripts.shcode2exe
  - remnux.scripts.dllcharacteristics
  - remnux.scripts.didier-stevens-scripts

remnux-scripts:
  test.nop:
    - require:
      - sls: remnux.scripts.java-idx-parser
      - sls: remnux.scripts.ex-pe-xor
      - sls: remnux.scripts.extract-swf
      - sls: remnux.scripts.nomorexor
      - sls: remnux.scripts.strdeob
      - sls: remnux.scripts.pyinstaller-extractor
      - sls: remnux.scripts.hash-identifier
      - sls: remnux.scripts.dexray
      - sls: remnux.scripts.accept-all-ips
      - sls: remnux.scripts.myip
      - sls: remnux.scripts.mynic
      - sls: remnux.scripts.anomy
      - sls: remnux.scripts.shcode2exe
      - sls: remnux.scripts.dllcharacteristics
      - sls: remnux.scripts.didier-stevens-scripts
