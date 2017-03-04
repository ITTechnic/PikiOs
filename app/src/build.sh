#!/usr/bin/env bash

set -e

[ -n "$LOG" ] || LOG="./../../built/build.log"

[ "$LOG" != "no" ] && (source ./scripts/runbuild.sh 2>&1 | tee "$LOG") || source ./scripts/runbuild.sh
