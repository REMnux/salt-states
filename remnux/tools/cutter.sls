# Name: Cutter
# Website: https://cutter.re
# Description: Reverse engineering platform powered by Rizin.
# Category: Statically Analyze Code: General
# Author: https://github.com/rizinorg/cutter/graphs/contributors
# License: GNU General Public License (GPL) v3.0: https://github.com/rizinorg/cutter/blob/master/COPYING
# Notes: If you're planning to use Cutter when running REMnux as a Docker container, you'll need to include the `--privileged` parameter when invoking the REMnux distro image in Docker.

remnux-tools-cutter-source:
  file.managed:
    - name: /usr/local/bin/cutter
    - source: https://github.com/rizinorg/cutter/releases/download/v2.4.1/Cutter-v2.4.1-Linux-x86_64.AppImage
    - source_hash: 96a3af26feb29806d52e9b2639ce9d6917d6424ac2a5b991585a4e440e56eb40
    - mode: 755

remnux-tools-cutter-icon:
  file.managed:
    - name: /usr/share/icons/cutter.svg
    - source: https://raw.githubusercontent.com/rizinorg/cutter/v2.4.1/src/img/cutter.svg
    - source_hash: 4ad117f6d8fc9fffc1359d1eef7f3f1c68db0f74eebebc998fa47b89bab81832
    - mode: 644
    - makedirs: True
    - watch:
      - file: remnux-tools-cutter-source