# Set the title of the current Terminal to the specified string
function title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

# Show the IP address of the primary network interface
function myip4 {
  ip addr | grep -A 1 " en" | grep "inet" | cut -f 6 -d " " | cut -f 1 -d "/"
}
function myip6 {
  ip -6 addr | grep inet6 | awk -F '[ \t]+|/' '{print $3}' | grep -v "^::1"
}
function myip {
  ipv4=`myip4`
  ipv6=`myip6`
  if [ ${#ipv4} -gt 0 ]; then
  	echo $ipv4
  else
  	if [ ${#ipv6} -gt 0 ]; then
  		echo $ipv6
  	fi
  fi
}

# Renew DCHP release using a single command
alias renew-dhcp="echo 'Old IP: `myip`' && sudo dhclient -r && sudo dhclient && echo 'New IP: `myip`'"

# Clean up and convert encodings when examining shellcode
function unicode2hex-escaped {
  perl -pe 's/[^a-f\d]//gi; s/(..)(..)/\\x$2\\x$1/g;' ${*};
}
function unicode2raw {
  perl -pe 's/[^a-f\d]//gi; s/(..)(..)/chr(hex($2)).chr(hex($1))/ge;' ${*};
}
function hex-escaped2raw () 
{ 
  perl -pe 's/\\x(..)/chr(hex($1))/ge;' ${*}
}

# Use Intel's conventions when disassembling code with objdump
function objdump {
  /usr/bin/objdump -M intel ${*}
}

function fakedns {
  sudo /usr/local/bin/fakedns ${*}
}

# Useful for hard-coding a specific IP address until the next reboot
function set-static-ip {
  NIC_NAME=$( ip link | egrep '^2\:'| awk '{print $2}' | sed 's/.$//' )
  sudo ifconfig $NIC_NAME ${*} netmask 255.255.255.0 up
  sudo systemctl restart network-manager
}

# A wrapper around the command to stop and start ngnix for old timers
function httpd {
  sudo systemctl ${*} nginx
}

# A wrapper around the command to stop and start SSH server for old timers
function sshd {
  sudo systemctl ${*} ssh
}

# Convenient names
alias notepad="scite"
alias calc="galculator"
alias ipconfig='ifconfig'
