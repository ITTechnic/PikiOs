PikiOs(k)
=========
Advanced Raspberry Pi Kiosk management.
BETA VERSION - This is not stable yet and may require manual config

This started as a fork of [FullPageOs](https://github.com/guysoft/FullPageOS) but has changed so much that is not really compatible any more
This project is only possible thanks to the hard work of the original developers of FullPageOS.

## Piki Tool

Piki comes with a helpful tool installed to aid with managing your kiosk, and brings lots of useful functions in to one place
https://github.com/twhiston/piki
run `piki` to see all the base commands and `piki [command] -h` to see help and subcommands for each base command.
You can also use `piki` locally to help you pre-configure boot files for your piki kiosks


## Basic Build Usage

This build is specifically made and tested on OSX, which is why the build is configured to run in a docker machine.
So if you are on linux the good news is you can avoid this entirely and just run ./scripts/build.sh locally to get an image

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

You can burn the image to disk FROM YOUR LOCAL MACHINE with `/env/burn.sh` (assumes that your sdcard is on disk2 like my mac laptop, sorry, this will be made flexible in future)

Be sure to set up your networks before you boot your pi, as the main dashboard will pause on loading if it does not have an internet connection
This can be disabled by running `piki httpd --disabled` (or locally with the sdcard mounted) `piki httpd --disabled --file /Volumes/boot/check_for_httpd`

## Customizing a build
To quickly override variables edit `env/config.local`



## Pi Image Troubleshooting

### Blank screen, or a blank screen with a single cursor line
you probably need to adjust your settings
- Put the Pi SSD into your local machine and if you have `piki` installed locally run `piki boot --type recovery --file /Volumes/boot/cmdline.txt`
    - If you dont have piki locally edit /Volumes/boot/cmdline.txt , after the word `rootwait` add ` 1`
- Boot your pi and you will be taken to the console.
- Run `raspi-config`
- advanced options > memory split > 128
- interfacing > full gpu acceleration
- localization setup
- restart
- `startx` should load the gui
- Power off
- Put the Pi SSD into your local machine and run `piki boot --type app --file /Volumes/boot/cmdline.txt`
    - Or edit /Volumes/boot/cmdline.txt and remove the ` 1` after `rootwait`
- Reboot your pi

Everything should work

### Black screen with a cursor

If it stalls after booting its because the script pauses if it cant connect to the web root,
so make sure you have network connections set up properly


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

- fix inital lighttpd config
- fix initial httpd check issues
- configurable boot screen for silent branded startups
- gpu set? #dtoverlay=vc4-kms-v3d
- ONEPAGEOS is tightly bound to their app url :( make this configurable
- work on variants, which are not really well supported atm, allow drop in installer scripts in variants
- image caching mid build for resumes?
- some folder structure changes for better separation
- turn all the var parsing stuff into a go routine and start to make the whole tool in go