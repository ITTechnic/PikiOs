#!/usr/bin/env bash

#override locale
if [ "$PIKI_OVERRIDE_LOCALE" != "default" ]
then
    sed -i '/^#.* '"$PIKI_OVERRIDE_LOCALE"' /s/^# //' /etc/locale.gen
    locale-gen
    update-locale LANG="$PIKI_OVERRIDE_LOCALE"
fi