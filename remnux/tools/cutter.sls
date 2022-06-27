# Name: Cutter
# Website: https://cutter.re
# Description: Reverse engineering platform powered by Rizin
# Category: Statically Analyze Code: General
# Author: https://github.com/rizinorg/cutter/graphs/contributors
# License: GNU General Public License (GPL) v3.0: https://github.com/rizinorg/cutter/blob/master/COPYING
# Notes: If you're planning to use Cutter when running REMnux as a Docker container, you'll need to include the `--privileged` parameter when invoking the REMnux distro image in Docker.

remnux-tools-cutter-source:
  file.managed:
    - name: /usr/local/bin/cutter
    - source: https://github.com/rizinorg/cutter/releases/download/v2.1.0/Cutter-v2.1.0-Linux-x86_64.AppImage
    - source_hash: 9ca1e0dbd1e8e2a16167a1e261b9977ceb8cf127ab52d8e3de84a41dce099017
    - mode: 755

remnux-tools-cutter-icon:
  file.managed:
    - name: /usr/share/icons/cutter.svg
    - source: https://raw.githubusercontent.com/rizinorg/cutter/v2.1.0/src/img/cutter.svg
    - source_hash: 4ad117f6d8fc9fffc1359d1eef7f3f1c68db0f74eebebc998fa47b89bab81832
    - mode: 644
    - makedirs: True
    - watch:
      - file: remnux-tools-cutter-source