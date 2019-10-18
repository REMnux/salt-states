include:
  - remnux.packages.libmozjs-52-0

symlink-spidermonkey:
  file.symlink:
    - name: /usr/bin/js
    - target: /usr/bin/js24
    - watch:
      - pkg: libmozjs-52-0
