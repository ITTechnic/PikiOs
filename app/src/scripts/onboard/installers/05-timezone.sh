#!/usr/bin/env bash

#override timezone
if [ "$PIKI_OVERRIDE_TIMEZONE" != "default" ]
then
    echo "$PIKI_OVERRIDE_TIMEZONE" > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata
fi