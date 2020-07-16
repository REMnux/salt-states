include:
  - remnux.packages.openssh

remnux-theme-ssh-sshd-disable-usedns:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: ^UseDNS no$
    - require:
      - sls: remnux.packages.openssh

remnux-theme-ssh-sshd-disable-gssapi:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: ^GSSAPIAuthentication no$
    - require:
      - sls: remnux.packages.openssh

remnux-theme-ssh-sshd-enable-printlastlog:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: ^PrintLastLog yes$
    - require:
      - sls: remnux.packages.openssh

remnux-theme-ssh-sshd-enable-tcpkeepalive:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: ^TCPKeepAlive yes$
    - require:
      - sls: remnux.packages.openssh

remnux-theme-ssh-sshd-enable-x11displayoffset:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: ^X11DisplayOffset 10$
    - require:
      - sls: remnux.packages.openssh

remnux-theme-ssh-sshd-disable-x11uselocalhost:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: '^#X11UseLocalhost yes$'
    - repl: 'X11UseLocalhost no'
    - require:
      - sls: remnux.packages.openssh