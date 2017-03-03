#!/usr/bin/env bash

unpack /filesystem/home/pi /home/pi pi
unpack /filesystem/home/root /root root
unpack /filesystem/boot /boot
unpack /filesystem/root_init /

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5B393194

apt-get update

apt-get remove -y --purge scratch squeak-plugins-scratch squeak-vm wolfram-engine python-minecraftpi minecraft-pi sonic-pi oracle-java8-jdk bluej greenfoot libreoffice-common libreoffice-core freepats
apt-get autoremove -y

#apt-get tools
apt-get -y --force-yes install python2.7 git screen checkinstall avahi-daemon libavahi-compat-libdnssd1 xterm