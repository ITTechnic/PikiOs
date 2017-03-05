#!/usr/bin/env bash

#override password
if [ "$PIKI_OVERRIDE_PASSWORD" != "default" ]
then
    echo "pi:$PIKI_OVERRIDE_PASSWORD" | chpasswd
fi