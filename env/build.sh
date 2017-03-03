#!/bin/bash
#This is the build script linked in to the docker container for triggering the image build
#Therefore you can add additional actions to this script without having to edit the underlying build process
cd /build/app/src
sudo modprobe loop
bash ./build.sh
exit