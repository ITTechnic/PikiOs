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
pushd  ${MYPROJROOT}
    rm -rf go go-${MYGOVER}

    ### Obtaining binaries to use
    ### Option 1: Using the pre-compiled ARM version (1.6.x and later!):
    wget https://storage.googleapis.com/golang/go${MYGOVER}.linux-armv6l.tar.gz
    tar xzf go${MYGOVER}.linux-armv6l.tar.gz
    mv go go-${MYGOVER}

    ### Install the package
    cp -rp ${MYPROJROOT}/go-${MYGOVER} /usr/local
    chown root:staff /usr/local/go-${MYGOVER}
    chmod -R g-s /usr/local/go-${MYGOVER}
    rm -f /usr/local/go
    ln -s /usr/local/go-${MYGOVER} /usr/local/go

    # Ensure Go is in your path (e.g., via your .profile)
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=${MYPROJROOT}
    # persist our go path inclusion
    echo "Add go tool, binary build location and gopath to vars"
    cat <<EOT >> /home/pi/.bashrc
export PATH=$PATH:/usr/local/go/bin:/home/pi/golang/bin
export GOPATH=${MYPROJROOT}
EOT

    ### Clean up
    rm -rf ${MYPROJROOT}/go-${MYGOVER}

popd

#############
# Instead of getting the binary directly you could build from source if required using something like the below
#
#
### Option 2: Building from source:
#
#    # Lower the ulimit to prevent problems
#    ulimit -s
#    ulimit -s 1024
#    ulimit -s
#
#    # Get the source
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