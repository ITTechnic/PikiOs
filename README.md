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

You can burk the image to disk with `/env/burn.sh`

Before booting the image add ` 1` to cmdline.txt to boot to the prompt
once at the prompt run `raspi-config` and make sure you configure

- your graphics card memory
- install the driver for GPU acceleration
- localization setup

then `vi /boot/cmdline.txt` and remove the ` 1` you added earlier, save and restart

## Troubleshooting

### Blank screen, or a blank screen with a single cursor line
you probably need to adjust your settings
- Put the Pi SSD into your local machine and edit cmdline.txt. At the end of the file add ` 1`
- Boot your pi and you will be taken to the console.
- Run `raspi-config`
- advanced options > memory split > 128
- interfacing > full gpu acceleration
- restart
- `startx` should load the gui
- Power off
- Edit cmdline.txt again and remove the ` 1`
- Reboot your pi

Everything should work

### Black screen with a cursor

If it stalls after booting its because the script pauses if it cant connect to the web root,
so make sure you have network connections set up.


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


- lighttpd vhost setup for proper vhosts when using php apps with a single entrypoint
- ONEPAGEOS is tightly bound to their app url :( make this configurable
- work on variants, which are not really well supported atm, allow drop in installer scripts in variants
- image caching mid build for resumes?
- some folder structure changes for better separation