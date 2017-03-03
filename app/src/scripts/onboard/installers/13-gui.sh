#!/usr/bin/env bash

#set up gui service
sed -i 's/#user-session=.*/user-session=fullpageos/g' /etc/lightdm/lightdm.conf
sed -i 's/#autologin-user=.*/autologin-user=pi/g' /etc/lightdm/lightdm.conf

# Set up x11vnc
sudo -u pi /home/pi/scripts/setX11vncPass raspberry
if [ ! -f /home/pi/.vnc/passwd ]; then
  echo "/home/pi/.vnc/passwd was not created. Trying again."
  sudo -u pi /home/pi/scripts/setX11vncPass raspberry
  if [ ! -f /home/pi/.vnc/passwd ]; then
    echo "/home/pi/.vnc/passwd was not created again. Giving up."
    echo "Failed to set a VNC password. Aborting build."
    exit 1
  fi
fi