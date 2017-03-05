#!/usr/bin/env bash

#reach pi by name
echo "$PIKI_OVERRIDE_HOSTNAME" > /etc/hostname
sed -i -e "s@raspberrypi@$PIKI_OVERRIDE_HOSTNAME@g" /etc/hosts

# allow network configuration via /boot/pikios-network.txt
sed -i "s@iface wlan0 @iface wlan0-raspbian @g" /etc/network/interfaces
sed -i "s@iface wlan1 @iface wlan1-raspbian @g" /etc/network/interfaces
echo "mapping wlan0" >> /etc/network/interfaces
echo "  script /root/bin/map_iface" >> /etc/network/interfaces
echo "mapping wlan1" >> /etc/network/interfaces
echo "  script /root/bin/map_iface" >> /etc/network/interfaces
echo "source /boot/pikios-network.txt" >> /etc/network/interfaces