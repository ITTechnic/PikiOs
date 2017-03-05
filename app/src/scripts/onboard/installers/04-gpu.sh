#!/usr/bin/env bash

if [ "${PIKI_INCLUDE_ACCELERATION}" == "yes" ]
then
    apt-get -y --force-yes install xcompmgr libgl1-mesa-dri mesa-utils

    # Hack to pass non-interactive install
    mv /usr/bin/whiptail /usr/bin/whiptail.bak
    echo "#!/bin/bash" > /usr/bin/whiptail
    echo "exit 0" >> /usr/bin/whiptail
    chmod 755 /usr/bin/whiptail
    apt-get -y --force-yes install rpi-chromium-mods
    rm /usr/bin/whiptail
    mv /usr/bin/whiptail.bak /usr/bin/whiptail

    systemctl enable enable_gpu_first_boot.service
else
    echo "gpu_mem=128" >> /boot/config.txt
fi


