include:
  - remnux.packages.git

remnux-config-docs:
  file.directory:
    - name: /usr/share/remnux/docs
    - makedirs: True

remnux-config-docs-git:
  git.cloned:
    - name: https://github.com/REMnux/docs.git
    - target: /usr/share/remnux/docs
    - require:
      - file: remnux-config-docs
      - pkg: git
