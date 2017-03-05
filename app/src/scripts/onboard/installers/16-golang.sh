#!/usr/bin/env bash

###############################################################################
# Building Go on the Raspberry Pi
###############################################################################
# Based on the work of Dave Cheney
#   http://dave.cheney.net/2015/09/04/building-go-1-5-on-the-raspberry-pi
# Also info in the docs:
#   https://github.com/golang/go/blob/master/src/make.bash
###############################################################################

### Set project area
export MYPROJROOT=/home/pi/golang
export MYGOVER=1.8
export MYGODEST=/usr/local/go-${MYGOVER}

### Preparation
mkdir ${MYPROJROOT}
cd ${MYPROJROOT}
rm -rf go go-${MYGOVER}

### Obtaining binaries to use
  ### Option 1: Using the pre-compiled ARM version (1.6.x and later!):

    # Get the release binaries
    cd ${MYPROJROOT}
    wget https://storage.googleapis.com/golang/go${MYGOVER}.linux-armv6l.tar.gz
    tar xzf go${MYGOVER}.linux-armv6l.tar.gz
    mv go go-${MYGOVER}

  ### Option 2: Building from source:

#    # Lower the ulimit to prevent problems
#    ulimit -s
#    ulimit -s 1024
#    ulimit -s
#
#    # Get the source
#    cd ${MYPROJROOT}
#    wget https://storage.googleapis.com/golang/go${MYGOVER}.src.tar.gz
#    tar xzf go${MYGOVER}.src.tar.gz
#    mv go go-${MYGOVER}
#
#    # Bootstrapping
#    export MYBOOTSTRAP=/usr/local/go
#    if [ ! -d ${MYBOOTSTRAP} ]; then
#        # Never had Go installed
#        cd ${MYPROJROOT}
#        wget http://dave.cheney.net/paste/go-linux-arm-bootstrap-c788a8e.tbz
#        tar xjf go-linux-arm-bootstrap-c788a8e.tbz
#        export MYBOOTSTRAP=~/Projects/go-linux-arm-bootstrap
#    fi
#    echo ${MYBOOTSTRAP}
#
#    # Build Go
#    cd ${MYPROJROOT}/go-${MYGOVER}/src
#    env GO_TEST_TIMEOUT_SCALE=10 GOROOT_BOOTSTRAP=${MYBOOTSTRAP} GOROOT_FINAL=${MYGODEST} ./all.bash

### Install the package
cd ${MYPROJROOT}
cp -rp ${MYPROJROOT}/go-${MYGOVER} /usr/local
chown root:staff /usr/local/go-${MYGOVER}
chmod -R g-s /usr/local/go-${MYGOVER}
rm -f /usr/local/go
ln -s /usr/local/go-${MYGOVER} /usr/local/go

### Test the installation

# Ensure Go is in your path (e.g., via your .profile)
export PATH=$PATH:/usr/local/go/bin

# persist our go path inclusion
cat <<EOT >> /home/pi/.bashrc
export PATH=$PATH:/usr/local/go/bin:/home/pi/golang/bin
export GOPATH=${MYPROJROOT}
EOT

cd $HOME
#go version
#    go version goX.Y.Z linux/arm
#    # Note: if you get something like "go: cannot find GOROOT directory: /foo/bar/blah"
#    # ensure that path exists. GOROOT_FINAL mediates that (above)

### Clean up
rm -rf ${MYPROJROOT}/go-${MYGOVER}

mkdir -p /home/pi/golang/src/github.com/twhiston
gitclone FULLPAGEOS_COMMAND_TOOL /home/pi/golang/src/github.com/twhiston/piki
export GOPATH=${MYPROJROOT}
#
pushd /home/pi/golang/src/github.com/twhiston/piki
    go get
    go build
popd