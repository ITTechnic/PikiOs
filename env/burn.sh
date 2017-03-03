#!/usr/bin/env bash
#Copy the image to the disk.
#Needs some work to allow passing the image name etc....

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

BUILD_PATH=${DIR}/../built

pushd ${BUILD_PATH}
    if [ -e *.img ]; then
        IMG_PATH=`ls | grep .img`
        echo "Found Image ${IMG_PATH} to burn"
        echo "Burning image to disk"
        sudo dd bs=1m if=${IMG_PATH}  of=/dev/rdisk2
    else
        echo "Could not find any images to burn in ${BUILD_PATH}"
    fi

popd

