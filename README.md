FullPageOS
==========
Docker Edition

See readme.orig.rst for full details of configuring build

## Basic Usage

In your local machine run
```
cd ./app/src/image
curl -J -O -L  http://downloads.raspberrypi.org/raspbian_latest
```
Then go back to the project root and run
```
docker-compose up
```
and your image will build.

If you want to change the build process you can alter app/build.sh

## Additional Changes

The local config file included in this project contains a different app repo to the base image
which has a simple react frontend and an api driven silex back end.

To use this you will need to set your root url to
http://localhost/frontend/src/client/index.html
