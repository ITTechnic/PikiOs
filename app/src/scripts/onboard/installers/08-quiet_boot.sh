#!/usr/bin/env bash


#if [ "$PIKI_QUIET_BOOT" != "false" ]
#then
#    echo 'make the startup quiet'
#    cat '\n\r disable_splash=1 avoid_warnings=1' >> /boot/config.txt
#    #console-null could instead be consoleblank=0 loglevel=1 rootfstype=ext4 if using fbi
#    cat '\n\r logo.nologo consoleblank=0 loglevel=1 rootfstype=ext4 quiet' >> /boot/cmdline.txt
#    systemctl disable getty@tty1
#fi

#apt-get install -y fbi
#
#cat <<EOT >> /etc/init.d/asplashscreen
##! /bin/sh
#### BEGIN INIT INFO
## Provides:          asplashscreen
## Required-Start:
## Required-Stop:
## Should-Start:
## Default-Start:     S
## Default-Stop:
## Short-Description: Show custom splashscreen
## Description:       Show custom splashscreen
#### END INIT INFO
#
#
#do_start () {
#
#    /usr/bin/fbi -T 1 -noverbose -a /assets/boot.png
#    exit 0
#}
#
#case "$1" in
#  start|"")
#    do_start
#    ;;
#  restart|reload|force-reload)
#    echo "Error: argument '$1' not supported" >&2
#    exit 3
#    ;;
#  stop)
#    # No-op
#    ;;
#  status)
#    exit 0
#    ;;
#  *)
#    echo "Usage: asplashscreen [start|stop]" >&2
#    exit 3
#    ;;
#esac
#
#:
#EOT
#
#chmod a+x /etc/init.d/asplashscreen
#insserv /etc/init.d/asplashscreen