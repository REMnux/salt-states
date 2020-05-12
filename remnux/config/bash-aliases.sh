# Set the title of the current Terminal to the specified string
function title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

# Show the IP address of the primary network interface
function myip {
  hostname -I | awk '{print $1}'
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

# Useful for hard-coding a specific IP address until the next reboot
function set-static-ip {
  NIC_NAME=$( ip link | egrep '^2\:'| awk '{print $2}' | sed 's/.$//' )
  sudo ifconfig $NIC_NAME ${*} netmask 255.255.255.0 up
  sudo systemctl restart network-manager
}

# Convenient names
alias notepad="scite"
alias calc="galculator"
alias ipconfig='ifconfig'