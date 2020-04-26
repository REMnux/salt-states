i386-arch:
  cmd.run:
    - name: dpkg --add-architecture i386
    - unless: dpkg --print-foreign-architectures | grep i386

apt-update:
  pkg.uptodate:
    - refresh: True
    - require:
      - cmd: i386-arch

libc6:
  pkg.installed:
    - name: libc6
    - require:
      - pkg: apt-update

libstdc++6:
  pkg.installed:
    - name: libstdc++6
    - require:
      - pkg: apt-update

libncurses5:i386:
  pkg.installed:
    - name: libncurses5:i386 
    - require:
      - pkg: apt-update
    
zlib1g:i386:
  pkg.installed:
    - name: zlib1g:i386
    - require:
      - pkg: apt-update