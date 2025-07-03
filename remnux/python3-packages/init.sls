include:
  - remnux.python3-packages.androguard
  - remnux.python3-packages.ioc-parser
  - remnux.python3-packages.ipwhois
  - remnux.python3-packages.jsbeautifier
  - remnux.python3-packages.mitmproxy
  - remnux.python3-packages.olefile
  - remnux.python3-packages.peframe
  - remnux.python3-packages.pyelftools
  - remnux.python3-packages.r2pipe
##  - remnux.python3-packages.virustotal-api - no application to use, should it be installed? How will user access library?
  - remnux.python3-packages.xortool
  - remnux.python3-packages.xxxswf
  - remnux.python3-packages.thug
  - remnux.python3-packages.xlmmacrodeobfuscator
  - remnux.python3-packages.unicode
  - remnux.python3-packages.volatility3
  - remnux.python3-packages.fakemail
  - remnux.python3-packages.dc3-mwcp
##  - remnux.python3-packages.ratdecoders - not working with most recent release of androguard
  - remnux.python3-packages.time-decode
  - remnux.python3-packages.pcodedmp
  - remnux.python3-packages.droidlysis
  - remnux.python3-packages.malwoverview
  - remnux.python3-packages.chepy
  - remnux.python3-packages.frida
  - remnux.python3-packages.stringsifter
  - remnux.python3-packages.oletools
  - remnux.python3-packages.unfurl
  - remnux.python3-packages.speakeasy
  - remnux.python3-packages.msoffcrypto-tool
  - remnux.python3-packages.qiling
  - remnux.python3-packages.pe-tree
  - remnux.python3-packages.hachoir
  - remnux.python3-packages.msg-extractor
  - remnux.python3-packages.name-that-hash
  - remnux.python3-packages.malchive
  - remnux.python3-packages.vivisect
  - remnux.python3-packages.pcode2code
  - remnux.python3-packages.mail-parser
  - remnux.python3-packages.csce
  - remnux.python3-packages.dnfile
  - remnux.python3-packages.dotnetfile
  - remnux.python3-packages.debloat
  - remnux.python3-packages.peepdf-3
  - remnux.python3-packages.dissect
  - remnux.python3-packages.magika
  - remnux.python3-packages.thefuzz
  - remnux.python3-packages.fakenet-ng
  - remnux.python3-packages.vipermonkey
  ## Vipermonkey - cannot import name 'Iterable' from 'collections' - needs to be from collections.abc import Iterable
  - remnux.python3-packages.balbuzard
  - remnux.python3-packages.brxor
##  - remnux.python3-packages.viper-framework - completely deprecated - may move to viper2

remnux-python3-packages:
  test.nop:
    - require:
      - sls: remnux.python3-packages.androguard
      - sls: remnux.python3-packages.ioc-parser
      - sls: remnux.python3-packages.ipwhois
      - sls: remnux.python3-packages.jsbeautifier
      - sls: remnux.python3-packages.mitmproxy
      - sls: remnux.python3-packages.olefile
      - sls: remnux.python3-packages.peframe
      - sls: remnux.python3-packages.pyelftools
      - sls: remnux.python3-packages.r2pipe
      ## r2pipe - unused by any tool, not installing library globally in Noble
##      - sls: remnux.python3-packages.virustotal-api - no application to use, should it be installed? How will user access library?
      - sls: remnux.python3-packages.xortool
      - sls: remnux.python3-packages.xxxswf
      ## xxxswf - contains deprecated functions for py3 in noble
      - sls: remnux.python3-packages.thug
      - sls: remnux.python3-packages.xlmmacrodeobfuscator
      - sls: remnux.python3-packages.unicode
      - sls: remnux.python3-packages.volatility3
      - sls: remnux.python3-packages.fakemail
      - sls: remnux.python3-packages.dc3-mwcp
##      - sls: remnux.python3-packages.ratdecoders - not working with most recent release of androguard
      - sls: remnux.python3-packages.time-decode
      - sls: remnux.python3-packages.pcodedmp
      - sls: remnux.python3-packages.droidlysis
      - sls: remnux.python3-packages.malwoverview
      - sls: remnux.python3-packages.chepy
      - sls: remnux.python3-packages.frida
      - sls: remnux.python3-packages.stringsifter
      ## stringsifter - pyproject.toml pins numpy at 1.24.4 but is not compatible with noble
      - sls: remnux.python3-packages.oletools
      - sls: remnux.python3-packages.unfurl
      - sls: remnux.python3-packages.speakeasy
      - sls: remnux.python3-packages.msoffcrypto-tool
      - sls: remnux.python3-packages.qiling
      - sls: remnux.python3-packages.pe-tree
      - sls: remnux.python3-packages.hachoir
      - sls: remnux.python3-packages.msg-extractor
      - sls: remnux.python3-packages.name-that-hash
      - sls: remnux.python3-packages.malchive
      - sls: remnux.python3-packages.vivisect
      - sls: remnux.python3-packages.pcode2code
      - sls: remnux.python3-packages.mail-parser
      - sls: remnux.python3-packages.csce
      - sls: remnux.python3-packages.dnfile
      - sls: remnux.python3-packages.dotnetfile
      - sls: remnux.python3-packages.debloat
      - sls: remnux.python3-packages.peepdf-3
      - sls: remnux.python3-packages.dissect
      - sls: remnux.python3-packages.magika
      - sls: remnux.python3-packages.thefuzz
      - sls: remnux.python3-packages.fakenet-ng
      - sls: remnux.python3-packages.vipermonkey
      - sls: remnux.python3-packages.balbuzard
      - sls: remnux.python3-packages.brxor
##      - sls: remnux.python3-packages.viper-framework - completely deprecated - may move to viper2
