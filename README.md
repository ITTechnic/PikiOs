FullPageOS
==========
Docker Edition

See readme.orig.rst for full details of configuring build.
This build is made so that it is easier to build this image on a mac or pc, as the build process happens in a linux container
It also moves the requirements, local config and build artifacts out of the build process folders to make organization cleaner
and projects a little neater.

## Basic Usage

In your local machine run
```
cd ./image
curl -J -O -L  http://downloads.raspberrypi.org/raspbian_latest
```
Then go back to the project root and run
```
docker-compose up
```
and your image will build.

The final image will be output in `./built/*.img`

If you want to change the build process you can alter env/build.sh

## Troubleshooting

If you boot to a blank screen, or a blank screen with a single cursor line then you probably need to adjust your settings
- Put the Pi SSD into your local machine and edit cmdline.txt. At the end of the file add ` 1`
- Boot your pi and you will be taken to the console.
- Run `raspi-config`
- advanced options > memory split > 128
- interfacing > ssh on
- interfacing > full gpu acceleration
- advanced options > expand filesystem
- restart
- `startx` should load the gui
- Power off
- Edit cmdline.txt again and remove the ` 1`
- Reboot your pi

Everything should work

## Additional Changes

- The local config file included in this project contains a different app repo to the base image
    - react frontend
    - api driven silex back end
    - see [FullPageDashboard - fork](https://github.com/twhiston/FullPageDashboard/tree/rewrite)
- PHP version updated to 7.0
- Removed some code that was specific to the original site repo from the build process to make it more generic
- Moved around config files and broke up scripts, more to do on this in future
- Files copied to the pi for execution in the build process are now contained in app/src/scripts/onboard to allow greater granularity
- removed nightly build scripts

## TODO
- change the way variants work, move their location and allow drop in installer scripts
- image caching mid build for resumes?