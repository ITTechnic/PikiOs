#!/usr/bin/env bash

#override password
if [ "$FULLPAGEOS_OVERRIDE_PASSWORD" != "default" ]
then
    echo "pi:$FULLPAGEOS_OVERRIDE_PASSWORD" | chpasswd
fi