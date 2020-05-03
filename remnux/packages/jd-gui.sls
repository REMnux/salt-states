# Name: JD-GUI Java Decompiler
# Website: https://java-decompiler.github.io/
# Description: Java decompiler with GUI
# Category: Examine browser malware: Java
# Author: Emmanuel Dupuy
# License: https://github.com/java-decompiler/jd-gui/blob/master/LICENSE
# Notes: 

include:
  - remnux.packages.xdg-utils
  - remnux.packages.default-jre

remnux-xdg-directory-create:
  file.directory:
    - names: 
      - /usr/share/desktop-directories/
      - /usr/share/icons/hicolor/    
    - user: root
    - group: root
    - mode: 755
    - makedirs: true
    - watch:
      - sls: remnux.packages.xdg-utils

remnux-jdgui-deb:
  pkg.installed:
    - sources:
      - jd-gui: https://github.com/java-decompiler/jd-gui/releases/download/v1.6.6/jd-gui-1.6.6.deb
    - require:
      - sls: remnux.packages.xdg-utils

remnux-tools-jdgui-wrapper:
  file.managed:
    - name: /usr/local/bin/jd-gui
    - mode: 755
#    - watch:
#      - pkg: remnux-jdgui-deb
    - contents:
        #!/bin/bash
        java -jar /opt/jd-gui/jd-gui.jar ${*}
