include:
  - remnux.packages.default-jre
  - remnux.packages.libcommons-lang3-java
  - remnux.packages.libbcprov-java

remnux-packages-pdftk-java:
  pkg.installed:
    - sources: 
        - pdftk-java: http://mirrors.kernel.org/ubuntu/pool/universe/p/pdftk-java/pdftk-java_3.0.2-2_all.deb
    - require:
        - sls: remnux.packages.default-jre
        - sls: remnux.packages.libcommons-lang3-java
        - sls: remnux.packages.libbcprov-java