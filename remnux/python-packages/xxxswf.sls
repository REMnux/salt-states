# Source:  https://bitbucket.org/Alexander_Hanel/xxxswf.git
# Commit:  c231234
include:
  - remnux.packages.git
  - remnux.packages.python-pip
  - remnux.packages.python-yara
  - remnux.python-packages.pylzma

remnux-pip-xxxswf:
  pip.installed:
    - name: git+https://bitbucket.org/Alexander_Hanel/xxxswf.git@c231234
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
      - sls: remnux.packages.python-yara
      - sls: remnux.python-packages.pylzma
