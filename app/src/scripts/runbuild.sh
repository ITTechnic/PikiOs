#!/usr/bin/env bash

set -e

define(){ IFS='\n' read -r -d '' ${1} || true; }

BUILD_SCRIPT__PATH=$(dirname $(realpath -s $BASH_SOURCE))

COMMON_PATH=${BUILD_SCRIPT__PATH}/onboard/common.sh

source ${COMMON_PATH}

FULLPAGEOS_PATH=$(dirname $(realpath -s $0))

pushd $FULLPAGEOS_PATH
  export FULLPAGEOS_COMMIT=`git rev-parse HEAD`
popd

BUILD_VARIANT=default
BUILD_FLAVOR=default
WORKSPACE_POSTFIX=

if [ "$#" -gt 0 ]; then
  BUILD_VARIANT=$1
fi
if [ "$#" -gt 1 ]; then
  BUILD_FLAVOR=$2
fi

if [ $BUILD_VARIANT != 'default' ]; then
  WORKSPACE_POSTFIX=-$BUILD_VARIANT

  export VARIANT_BASE="${ROOT_DIR}/app/variants/${BUILD_VARIANT}"
  [ -d $VARIANT_BASE ] || die "Could not find Variant $BUILD_VARIANT"

  if [ $BUILD_FLAVOR == '' ] || [ $BUILD_FLAVOR == 'default' ]
  then
    VARIANT_CONFIG=$VARIANT_BASE/config
    FLAVOR_CONFIG=
  else
    VARIANT_CONFIG=$VARIANT_BASE/config
    FLAVOR_CONFIG=$VARIANT_BASE/config.$BUILD_FLAVOR
  fi

  if [ -n "$FLAVOR_CONFIG" ] && [ ! -f $FLAVOR_CONFIG ]
  then
    die "Could not find config file $FLAVOR_CONFIG"
  fi
fi

echo -e "--> Building VARIANT $BUILD_VARIANT, FLAVOR $BUILD_FLAVOR"

source $FULLPAGEOS_PATH/config
[ "$CONFIG_ONLY" == "yes" ] || source ${BUILD_SCRIPT__PATH}/fullpageos