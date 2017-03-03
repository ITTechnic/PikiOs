#!/usr/bin/env bash

#override locale
if [ "$FULLPAGEOS_OVERRIDE_LOCALE" != "default" ]
then
    sed -i '/^#.* '"$FULLPAGEOS_OVERRIDE_LOCALE"' /s/^# //' /etc/locale.gen
    locale-gen
    update-locale LANG="$FULLPAGEOS_OVERRIDE_LOCALE"
fi