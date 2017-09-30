include:
  - remnux.packages.git

remnux-docs-directory:
  file.directory:
    - name: /usr/share/remnux/docs
    - makedirs: True

remnux-docs-git:
  git.latest:
    - name: https://github.com/REMnux/docs.git
    - target: /usr/share/remnux/docs
    - require:
      - file: remnux-docs-directory
      - pkg: git
