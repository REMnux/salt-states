# Name: OpenSSH
# Website: https://www.openssh.com
# Description: Initiate and receive SSH and SFTP connections.
# Category: General Utilities
# Author: https://github.com/openssh/openssh-portable/blob/master/CREDITS
# License: BSD licence: https://github.com/openssh/openssh-portable/blob/master/LICENCE
# Notes: sftp, ssh, sshd <start|stop|status>, etc.

openssh-client:
  pkg.installed

openssh-server:
  pkg.installed