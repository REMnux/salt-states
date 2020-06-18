#!/bin/bash

#
# A wrapper for launching Docker even if its service is disabled.
# 

if [ ! -e /usr/bin/docker ]; then
	echo "Cannot locate /usr/bin/docker. Exiting."
	exit 1
fi

# Before launcing Docker, start the Docker daemon if it's not running.
if ! ps ax | grep -v grep | grep "/usr/bin/dockerd" > /dev/null
then
	sudo systemctl start docker
	sleep 1
fi

# Launch Docker with "sudo", so that the user doesn't have to bother with "sudo".
sudo /usr/bin/docker ${*}