#!/usr/bin/env bash

if [ "$PIKI_INCLUDE_CHROMIUM" == "yes" ]
then
    apt-get install -y --force-yes chromium-browser
    sudo -u pi sed -i 's@%BROWSER_START_SCRIPT%@/home/pi/scripts/start_chromium_browser@g' /home/pi/scripts/run_pikios
fi