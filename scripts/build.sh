#!/bin/bash
#This is the build script linked in to the docker container for triggering the image build
#Therefore you can add additional actions to this script without having to edit the underlying build process
# All paths must be relative to the docker container root.
# All files are linking to the /build/ folder (ie this script is located at /build/scripts/build.sh)
cd /build/app/src
sudo modprobe loop
time bash ./build.sh
exit