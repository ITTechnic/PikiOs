#!/usr/bin/env bash

### Install Piki
echo "Get Piki Tool from git"
PIKI_SRC=${GOPATH}/src/github.com/twhiston/piki
mkdir -p ${PIKI_SRC}

cat <<EOT >> /home/pi/.bashrc
export PIKI_SRC=${PIKI_SRC}
EOT

chown -R pi ${GOPATH}
gitclone PIKI_COMMAND_TOOL ${PIKI_SRC}

#getting of dependencies and tools is deferred to first boot because of threading issues with building this image in docker
systemctl enable piki_first_boot.service