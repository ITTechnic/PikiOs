#!/usr/bin/env bash

pushd ./../built

    FILENAME=$(basename `ls . |  grep .img | tail -n 1` .img)
    PIKI_FILENAME=$(echo $FILENAME-`cat ../filesystem/root/etc/fullpageos_version` | sed 's/raspbian/fullpageos/')
    mv ${FILENAME}.img $PIKI_FILENAME.img
    zip $PIKI_FILENAME.zip $PIKI_FILENAME.img

popd
