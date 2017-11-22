include:
  - remnux.packages.libmozjs-24-bin

symlink-spidermonkey:
  file.symlink:
    - name: /usr/bin/js
    - target: /usr/bin/js24
    - watch:
      - pkg: remnux-packages-libmozjs-24-bin
