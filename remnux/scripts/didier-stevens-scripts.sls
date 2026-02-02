# Name: Didier Stevens Scripts
# Website: https://blog.didierstevens.com
# Description: A collection of Python scripts for analyzing suspicious files and data from Didier Stevens.
# Category: Examine Static Properties: Deobfuscation, Analyze Documents: General
# Author: Didier Stevens: https://twitter.com/DidierStevens
# License: Public Domain
# Notes: 

{% set files = [('1768.py','38aed900f5fe0c9272e66451266ab6888401b95c50920eff268bbbba4db4b040'),
                ('base64dump.py','946fcd48a44f50817c9a623d3de60a4e589cf3418052267eb1287e5ee5e5ff9c'),
                ('cs-analyze-processdump.py','997fe227ba27473acce80f88e5a8c6dbf3da546e9550b6ec319f05978bff0611'),
                ('cs-decrypt-metadata.py','c1db49356acb525c8aade75c15014f83cfae47f6d7a158f02d84402294aa0a35'),
                ('cs-extract-key.py','2dad421728ec892b6479edd561cad414bc73f41893d9152c68083dc92c32d94d'),
                ('cs-parse-traffic.py','76f5d59e4435498f0f5309af97ec6ce645611da21b4b12be50c32f1120e45b7f'),
                ('cut-bytes.py','b5f0ed0af51059da5f7df44d452653a27662a6fc9d4ea5956ccec21dfcb56849'),
                ('decode-vbe.py','1c2287db4df125814ae6f547af0c943deb2b9a282cbec5f55723b8e13285c85e'),
                ('disitool.py','e3dc083ce8ee2d3a16b16a33460a5052586505876263272ebfddbffb6e2a661a'),
                ('dnsresolver.py','5b98ad4bdc459a228f8e98d9502e066bfaf7f10537905918995cbb55c5c9f87c'),
                ('emldump.py','cae10ad495864d196edc464148990be84e84480860045ff8ea0172e0f8ea8a86'),
                ('file-magic.py','bae00a6c34e08095b586798b7d27783e938707ce05621b4d9a5b6da7b7eb742e'),
                ('format-bytes.py','7b36fc6b9fdc3f4533afae6b7b443a3fa0cd20919e1123621cfdc43571e1d739'),
                ('hex-to-bin.py','4e06d5d80c60f88b0289072124d8c6e0c1cf541dbcc58c41f1edd87f2fa8a3f5'),
                ('msoffcrypto-crack.py','f0a78b7263704d8740a7d4738a8b3d5cfc6037de619953b444a0019551826367'),
                ('myjson-filter.py','c09e7ed57017ad765586bafa72c2b91eb2199a92d28755ba81ef4345eefbaaa9'),
                ('myjson-transform.py','e790bc09b37cd9b452920cd1452d98eb3890a0f39b86fb36337471fa11ae27d9'),
                ('numbers-to-string.py','332822ca13b283da92f399ac407ab0a99ab18df32e5996cee9386be54ba8a225'),
                ('oledump.py','463b437a844204988e273aa3ddac34ec9a52c24cf1e40e490dbdbc2485e43ffa'),
                ('pdfid.py','e958a01f1c2596470f27d3c308061b85d7059ff476a58d74f1957a71b4f1248f'),
                ('pdf-parser.py','5cb6f1828d2aee18c309bcbae955d48dc6c65354ed2fa340ea6cc3b4ff18dbf1'),
                ('pdftool.py','8e0fcd2f1eee00eb02a45448d8557f1531e885891a7c93f3272ee8acd47c6fca'),
                ('pecheck.py','375482fd2ac5079a5a47a81857daa2c203d9778359edaabf1b4cc927daa5dc7a'),
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
                ('zipdump.py','8035ba624a449d55386b697e1daf9bd32729af1f08dd2d16f2e278bef6dbfdd6'),
] %}

{% set supplementals = [('1768.json','b28db56e03efeac3120769d260a03e3209b1d8feacedb50f66627f26507d4b03'),
                        ('file-magic.def','79d6edaba6103e9340dd3028bc85ae4e92fbb33f5efce84f8b77e6fcb7bcfaf5'),
                        ('format-bytes.library','8888bb8a5a9be453545e916d655befe2780c3450076c19b48fcb7e07468cd091'),
                        ('pdfid.ini','ded2e1b4191c8e1914ee53481e32cedc238ad4e16b209ed1cc734896cd8b94cd'),
]%}
{% set commit = '8466281c04993e460bc4124dae744ef8734462d2' %}

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
