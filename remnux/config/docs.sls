remnux-docs-directory:
  file.directory:
    - name: /usr/share/remnux/docs
    - mkdirs: True

remnux-docs-git:
  git.latest:
    - name: https://github.com/REMnux/docs.git
    - target: /usr/share/remnux/docs
    - require:
      - file: remnux-docs-directory
