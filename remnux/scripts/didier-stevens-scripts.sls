# Name: Didier Stevens Scripts
# Website: https://blog.didierstevens.com
# Description: A collection of Python scripts for analyzing suspicious files and data from Didier Stevens.
# Category: Examine Static Properties: Deobfuscation, Analyze Documents: General
# Author: Didier Stevens: https://x.com/DidierStevens
# License: Public Domain
# Tools: oledump.py|Analyze OLE2 Structured Storage files.|https://blog.didierstevens.com/programs/oledump-py/|Analyze Documents: Microsoft Office
# Tools: pdfid.py|Identify suspicious elements of the PDF file.|https://blog.didierstevens.com/programs/pdf-tools/|Analyze Documents: PDF
# Tools: pdf-parser.py|Examine elements of the PDF file.|https://blog.didierstevens.com/programs/pdf-tools/|Analyze Documents: PDF
# Tools: rtfdump.py|Analyze a suspicious RTF file.|https://blog.didierstevens.com/2018/12/10/update-rtfdump-py-version-0-0-9/|Analyze Documents: Microsoft Office
# Tools: emldump.py|Parse and analyze EML files.|https://blog.didierstevens.com/2020/11/29/update-emldump-py-version-0-0-11/|Analyze Documents: Email Messages
# Tools: base64dump.py|Locate and decode strings encoded in Base64 and other common encodings.|https://blog.didierstevens.com/2020/07/03/update-base64dump-py-version-0-0-12/|Examine Static Properties: Deobfuscation, Analyze Documents: General
# Tools: decode-vbe.py|Decode encoded VBS scripts (VBE).|https://blog.didierstevens.com/2016/03/29/decoding-vbe/|Statically Analyze Code: Scripts
# Tools: zipdump.py|Analyze zip-compressed files.|https://blog.didierstevens.com/2020/07/27/update-zipdump-py-version-0-0-20/|Analyze Documents: Microsoft Office
# Tools: xmldump.py|Extract contents of XML files, in particular OOXML-formatted Microsoft Office documents.|https://blog.didierstevens.com/2017/12/18/new-tool-xmldump-py/|Analyze Documents: Microsoft Office
# Tools: msoffcrypto-crack.py|Recover the password of an encrypted Microsoft Office document.|https://blog.didierstevens.com/2018/12/31/new-tool-msoffcrypto-crack-py/|Analyze Documents: Microsoft Office
# Tools: pdftool.py|Analyze PDF files to identify incremental updates to the document.|https://blog.didierstevens.com/2021/01/31/new-tool-pdftool-py/|Analyze Documents: PDF
# Tools: xor-kpa.py|Implement a XOR known plaintext attack.|https://blog.didierstevens.com/2017/06/06/update-xor-kpa-py-version-0-0-5/|Examine Static Properties: Deobfuscation
# Tools: cut-bytes.py|Cut out a part of a data stream.|https://blog.didierstevens.com/2015/10/14/cut-bytes-py/|Examine Static Properties: Deobfuscation
# Tools: format-bytes.py|Decompose structured binary data with format strings.|https://blog.didierstevens.com/2020/02/17/update-format-bytes-py-version-0-0-13/|Examine Static Properties: Deobfuscation
# Tools: translate.py|Translate bytes according to a Python expression.|https://blog.didierstevens.com/programs/translate/|Examine Static Properties: Deobfuscation
# Tools: sets.py|Perform set operations on lines or bytes in text files.|https://blog.didierstevens.com/2017/03/05/new-tool-sets-py/|Examine Static Properties: Deobfuscation
# Tools: 1768.py|Analyze Cobalt Strike beacons.|https://blog.didierstevens.com/2021/05/22/update-1768-py-version-0-0-6/|Examine Static Properties: Deobfuscation
# Tools: cs-decrypt-metadata.py|Decrypt Cobalt Strike metadata.|https://blog.didierstevens.com/2021/11/12/update-cs-decrypt-metadata-py-version-0-0-2/|Examine Static Properties: Deobfuscation
# Tools: pecheck.py|Analyze static properties of PE files.|https://blog.didierstevens.com/2020/03/15/pecheck-py-version-0-7-10/|Examine Static Properties: PE Files
# Tools: xorsearch.py|Search for XOR, ROL, ROT, and SHIFT encoded strings with YARA and regex support.|https://blog.didierstevens.com/2020/08/23/new-tool-xorsearch-py/|Examine Static Properties: Deobfuscation
# Tools: re-search.py|Search files using regular expressions from a built-in library or custom patterns.|https://blog.didierstevens.com/2023/04/03/update-re-search-py-version-0-0-22/|Examine Static Properties: Deobfuscation
# Tools: strings.py|Extract ASCII and Unicode strings from binary files with length sorting and filtering.|https://blog.didierstevens.com/2020/12/19/update-strings-py-version-0-0-6/|Examine Static Properties: General
# Tools: file-magic.py|Identify file types using the Python magic module.|https://blog.didierstevens.com/2018/07/11/new-tool-file-magic-py/|Examine Static Properties: General
# Tools: hex-to-bin.py|Convert hexadecimal text dumps to binary data.|https://blog.didierstevens.com/2020/04/19/update-hex-to-bin-py-version-0-0-5/|Examine Static Properties: Deobfuscation
# Tools: numbers-to-string.py|Translate number sequences into ASCII characters.|https://blog.didierstevens.com/2020/12/12/update-numbers-to-string-py-version-0-0-11/|Examine Static Properties: Deobfuscation
# Tools: disitool.py|Extract, delete, copy, and inject digital signatures in PE files.|https://blog.didierstevens.com/programs/disitool/|Examine Static Properties: PE Files
# Tools: dnsresolver.py|DNS resolver tool for dynamic analysis with wildcard and tracking support.|https://blog.didierstevens.com/2021/07/15/new-tool-dnsresolver-py/|Explore Network Interactions: Services
# Tools: cs-analyze-processdump.py|Analyze Cobalt Strike beacon process dumps to detect sleep mask encoding.|https://blog.didierstevens.com/2021/11/25/new-tool-cs-analyze-processdump-py/|Examine Static Properties: Deobfuscation
# Tools: cs-extract-key.py|Extract AES and HMAC keys from Cobalt Strike beacon process memory.|https://blog.didierstevens.com/2021/11/03/new-tool-cs-extract-key-py/|Examine Static Properties: Deobfuscation
# Tools: cs-parse-traffic.py|Decrypt and parse Cobalt Strike beacon network traffic.|https://blog.didierstevens.com/2021/11/29/new-tool-cs-parse-traffic-py/|Explore Network Interactions: Monitoring
# Tools: onedump.py|Extract and analyze embedded files from OneNote documents.|https://blog.didierstevens.com/2023/01/22/new-tool-onedump-py/|Analyze Documents: Microsoft Office
# Notes:

{% set files = [('1768.py','38aed900f5fe0c9272e66451266ab6888401b95c50920eff268bbbba4db4b040'),
                ('base64dump.py','946fcd48a44f50817c9a623d3de60a4e589cf3418052267eb1287e5ee5e5ff9c'),
                ('cs-analyze-processdump.py','997fe227ba27473acce80f88e5a8c6dbf3da546e9550b6ec319f05978bff0611'),
                ('cs-decrypt-metadata.py','c1db49356acb525c8aade75c15014f83cfae47f6d7a158f02d84402294aa0a35'),
                ('cs-extract-key.py','2dad421728ec892b6479edd561cad414bc73f41893d9152c68083dc92c32d94d'),
                ('cs-parse-traffic.py','ada645b042a0ee70a634c7057402964e2aa7af4f459ce957ec891ac4c4d351fd'),
                ('cut-bytes.py','b5f0ed0af51059da5f7df44d452653a27662a6fc9d4ea5956ccec21dfcb56849'),
                ('decode-vbe.py','1c2287db4df125814ae6f547af0c943deb2b9a282cbec5f55723b8e13285c85e'),
                ('disitool.py','e3dc083ce8ee2d3a16b16a33460a5052586505876263272ebfddbffb6e2a661a'),
                ('dnsresolver.py','238d81434c00f7a30aea593572ec8a6b3ae5cd5e20e344ecf301818d1a10a343'),
                ('emldump.py','cae10ad495864d196edc464148990be84e84480860045ff8ea0172e0f8ea8a86'),
                ('file-magic.py','bae00a6c34e08095b586798b7d27783e938707ce05621b4d9a5b6da7b7eb742e'),
                ('format-bytes.py','7b36fc6b9fdc3f4533afae6b7b443a3fa0cd20919e1123621cfdc43571e1d739'),
                ('hex-to-bin.py','4e06d5d80c60f88b0289072124d8c6e0c1cf541dbcc58c41f1edd87f2fa8a3f5'),
                ('msoffcrypto-crack.py','f0a78b7263704d8740a7d4738a8b3d5cfc6037de619953b444a0019551826367'),
                ('myjson-filter.py','c09e7ed57017ad765586bafa72c2b91eb2199a92d28755ba81ef4345eefbaaa9'),
                ('myjson-transform.py','e790bc09b37cd9b452920cd1452d98eb3890a0f39b86fb36337471fa11ae27d9'),
                ('numbers-to-string.py','332822ca13b283da92f399ac407ab0a99ab18df32e5996cee9386be54ba8a225'),
                ('oledump.py','d4130e50df58a2e6b4d44f513374b479a591aaa5014abc63aa2391f5f303dd99'),
                ('pdfid.py','e958a01f1c2596470f27d3c308061b85d7059ff476a58d74f1957a71b4f1248f'),
                ('pdf-parser.py','628256f0c016347a6b838729499397106a89b327965b7d7f77e47c1be0bc603f'),
                ('pdftool.py','8e0fcd2f1eee00eb02a45448d8557f1531e885891a7c93f3272ee8acd47c6fca'),
                ('pecheck.py','cdc595b3f0fb7f483006ab2ff4d614b671e8826f60b3eecab3d1cf2aeb100008'),
                ('plugin_embeddedfile.py','af5bf0c5fb44612d9e8f75af24791f7403b5b3847ed8eb58448fb3a58aef6cd7'),
                ('plugin_nameobfuscation.py','3097f900eaca41669f551fd43c99be1e17666db1aac1ec8f0e04d1796795d61e'),
                ('plugin_triage.py','c6e6145f6cf9b28594d85d11d1681cd9c7db9a8d85938ba78f4905396ca9f85c'),
                ('re-search.py','292be9721ac7ccd1aff1f66d595b8057f47b4af1bdb33b4ceae9f5aa485b8d63'),
                ('reextra.py','b275098b6b67b12bad459732f52e5fb69cbc2348526a073fbaeca8587260d2b2'),
                ('rtfdump.py','5512f4ea5661ac8b0037aca7297ea94583f1899f22e29631e5715adce6640c75'),
                ('sets.py','eb514fe393e92f8a4ff75b9738408d49868741ac7ef212eda83a75e3482e5148'),
                ('sortcanon.py','1c3093546e7ec5f8424a9f03ca6999b2c67d7430c6f264885d4ad47b38786bdd'),
                ('strings.py','dedccaf0130aa8f0195bc10d25a31cab1924998b6f6f427cbb78781a65eeb482'),
                ('texteditor.py','c5d1578711cbb6f448f50d1e8e78aeff65e6161d0dcb7b8f2b19d7a85607db51'),
                ('translate.py','dabc4b19b1d176d5963d91d845aec9d04823ed2a2808bfd526388382177bf50e'),
                ('xmldump.py','713f575d02639b6359e1999de6d18f99c1fac369831c5eaf3f2000feab342a11'),
                ('xor-kpa.py','db51d2a64a0ee5673cb933f8a2fb5796e401fb7d46427da2c6d9c9749301af22'),
                ('xorsearch.py','bbfe319941456b9becea637a4dae01ec572b68fe2aeea22f29f4ccee7417fc6e'),
                ('zipdump.py','2b0fee76b04577d055449ad13d42b057022a1f3be913581eab375be5f19f28c4'),
] %}

{% set supplementals = [('1768.json','8824cec6f4ee2ec2f578558bdd014ae1ce8bc02752eb128b509d5740b0f4d553'),
                        ('file-magic.def','79d6edaba6103e9340dd3028bc85ae4e92fbb33f5efce84f8b77e6fcb7bcfaf5'),
                        ('format-bytes.library','8888bb8a5a9be453545e916d655befe2780c3450076c19b48fcb7e07468cd091'),
                        ('pdfid.ini','ded2e1b4191c8e1914ee53481e32cedc238ad4e16b209ed1cc734896cd8b94cd'),
]%}
{% set commit = 'dc978443977d831ca2051a88b411ff5716c770a5' %}

include:
  - remnux.packages.python3-virtualenv
  - remnux.packages.build-essential
  - remnux.packages.python3-dev

remnux-scripts-didier-stevens-venv:
  virtualenv.managed:
    - name: /opt/didier-stevens
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - yara-python
      - dnslib
      - python-magic
      - msoffcrypto-tool
      - pefile
      - olefile
      - pyzipper
      - pycryptodome
      - minidump
      - pyshark
    - require:
      - sls: remnux.packages.python3-virtualenv
      - sls: remnux.packages.build-essential
      - sls: remnux.packages.python3-dev

{% for file, hash in files %}
remnux-scripts-didier-stevens-{{ file }}:
  file.managed:
    - name: /opt/didier-stevens/bin/{{ file }}
    - source: https://raw.githubusercontent.com/DidierStevens/DidierStevensSuite/{{ commit }}/{{ file }}
    - source_hash: sha256={{ hash }}
    - mode: 755
    - makedirs: True
    - require:
      - virtualenv: remnux-scripts-didier-stevens-venv

remnux-scripts-didier-stevens-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/didier-stevens/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-didier-stevens-{{ file }}

remnux-scripts-didier-stevens-shebang-{{ file }}:
  file.replace:
    - name: /opt/didier-stevens/bin/{{ file }}
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/opt/didier-stevens/bin/python3\n'
    - prepend_if_not_found: True
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-didier-stevens-symlink-{{ file }}

remnux-scripts-didier-stevens-formatting-{{ file }}:
  file.replace:
    - name: /opt/didier-stevens/bin/{{ file }}
    - pattern: '\r'
    - repl: ''
    - backup: false
    - require:
      - file: remnux-scripts-didier-stevens-shebang-{{ file }}

{% endfor %}

{% set beta_commit = '439d2168ea1967f3c0836616d390405cadd07690' %}
{% set beta_files = [('onedump.py','67ddd82068c08ba1e873f96956f43f1d2c64cf7b67156e657e5822a849e08144'),
] %}

{% for file, hash in beta_files %}
remnux-scripts-didier-stevens-beta-{{ file }}:
  file.managed:
    - name: /opt/didier-stevens/bin/{{ file }}
    - source: https://raw.githubusercontent.com/DidierStevens/Beta/{{ beta_commit }}/{{ file }}
    - source_hash: sha256={{ hash }}
    - mode: 755
    - makedirs: True
    - require:
      - virtualenv: remnux-scripts-didier-stevens-venv

remnux-scripts-didier-stevens-beta-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/didier-stevens/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - file: remnux-scripts-didier-stevens-beta-{{ file }}

remnux-scripts-didier-stevens-beta-shebang-{{ file }}:
  file.replace:
    - name: /opt/didier-stevens/bin/{{ file }}
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/opt/didier-stevens/bin/python3\n'
    - prepend_if_not_found: True
    - backup: False
    - count: 1
    - require:
      - file: remnux-scripts-didier-stevens-beta-symlink-{{ file }}

remnux-scripts-didier-stevens-beta-formatting-{{ file }}:
  file.replace:
    - name: /opt/didier-stevens/bin/{{ file }}
    - pattern: '\r'
    - repl: ''
    - backup: false
    - require:
      - file: remnux-scripts-didier-stevens-beta-shebang-{{ file }}

{% endfor %}

{% for file, hash in supplementals %}
remnux-scripts-didier-stevens-supplemental-{{ file }}:
  file.managed:
    - name: /opt/didier-stevens/bin/{{ file }}
    - source: https://raw.githubusercontent.com/DidierStevens/DidierStevensSuite/{{ commit }}/{{ file }}
    - source_hash: sha256={{ hash }}
    - mode: 644
    - makedirs: True
    - require:
      - virtualenv: remnux-scripts-didier-stevens-venv
{% endfor %}
