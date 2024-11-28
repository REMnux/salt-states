# Remove the repository key
remnux-inetsim-key:
  file.absent:
    - name: /usr/share/keyrings/INETSIM-GPG-KEY.asc

# Remove the repository configuration
inetsim-repo:
  pkgrepo.absent:
    - name: deb [signed-by=/usr/share/keyrings/INETSIM-GPG-KEY.asc] http://www.inetsim.org/debian/ binary/
    - file: /etc/apt/sources.list.d/inetsim.list