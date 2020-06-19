#!/bin/bash

# Make sure each window has minimize, maximize, and close buttons.
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# Enable the Window List extension to display active windows at the bottom of the screen.
gsettings set org.gnome.shell enabled-extensions "['window-list@gnome-shell-extensions.gcampax.github.com']"

# Set the desktop background to black and display the REMnux logo in the center.
gsettings set org.gnome.desktop.background picture-uri "file:///usr/local/share/remnux/remnux-logo.png"
gsettings set org.gnome.desktop.background picture-options "centered"
gsettings set org.gnome.desktop.background primary-color "#000000000000"

# Set the screensaver background to black.
gsettings set org.gnome.desktop.screensaver primary-color "#000000000000"

# Disable idle session screen blanking and auto-lock
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled "false"

# Don't suspend the system due to inactivity
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "nothing"

# Define favorites
gsettings set org.gnome.shell favorite-apps "['gnome-terminal.desktop','firefox.desktop','nautilus.desktop']"