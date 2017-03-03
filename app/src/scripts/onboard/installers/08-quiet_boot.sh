#!/usr/bin/env bash


if [ "$FULLPAGEOS_QUIET_BOOT" != "false" ]
then
    echo 'make the startup quiet'
    cat 'disable_splash=1 avoid_warnings=1' >> /boot/config.txt
    #console-null could instead be consoleblank=0 loglevel=1 rootfstype=ext4 if using fbi
    cat 'logo.nologo console=null quiet' >> /boot/cmdline.txt
    systemctl disable getty@tty1

    #fbi -d /dev/fb0 --once --noverbose\
    #  --autozoom /path/to/image.png </dev/tty1 >/dev/tty1
fi