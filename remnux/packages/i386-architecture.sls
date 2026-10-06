{% from "remnux/osarch.sls" import osarch with context %}
{% if osarch == "arm64" %}

remnux-packages-i386-architecture-arm64-skip:
  test.show_notification:
    - text: "Skipped on arm64: 32-bit x86 (i386) packages are not available for this architecture."

{% else %}

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

libncurses6:i386:
  pkg.installed:
    - name: libncurses6:i386
    - require:
      - cmd: i386-arch

zlib1g:i386:
  pkg.installed:
    - name: zlib1g:i386
    - require:
      - cmd: i386-arch

{% endif %}
