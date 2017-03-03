#!/usr/bin/env bash

#override timezone
if [ "$FULLPAGEOS_OVERRIDE_TIMEZONE" != "default" ]
then
    echo "$FULLPAGEOS_OVERRIDE_TIMEZONE" > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata
fi