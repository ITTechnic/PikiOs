#!/usr/bin/env bash

pushd ./../built

    FILENAME=$(basename `ls . |  grep .img | tail -n 1` .img)
    FULLPAGEOS_FILENAME=$(echo $FILENAME-`cat ../filesystem/root/etc/fullpageos_version` | sed 's/raspbian/fullpageos/')
    mv ${FILENAME}.img $FULLPAGEOS_FILENAME.img
    zip $FULLPAGEOS_FILENAME.zip $FULLPAGEOS_FILENAME.img

popd
