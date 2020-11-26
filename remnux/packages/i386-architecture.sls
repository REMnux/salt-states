i386-arch:
  cmd.run:
    - name: dpkg --add-architecture i386 && apt-get update
    - unless: dpkg --print-foreign-architectures | grep i386

libc6:
  pkg.installed:
    - name: libc6
    - require:
      - cmd: i386-arch

libstdc++6:
  pkg.installed:
    - name: libstdc++6
    - require:
      - cmd: i386-arch

libncurses5:i386:
  pkg.installed:
    - name: libncurses5:i386
    - require:
      - cmd: i386-arch

zlib1g:i386:
  pkg.installed:
    - name: zlib1g:i386
    - require:
      - cmd: i386-arch
