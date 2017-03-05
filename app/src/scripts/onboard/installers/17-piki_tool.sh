#!/usr/bin/env bash

mkdir -p /home/pi/golang/src/github.com/twhiston
gitclone FULLPAGEOS_COMMAND_TOOL /home/pi/golang/src/github.com/twhiston/piki
export GOPATH=/home/pi/golang

pushd /home/pi/golang/src/github.com/twhiston/piki
    go get
    go build
popd