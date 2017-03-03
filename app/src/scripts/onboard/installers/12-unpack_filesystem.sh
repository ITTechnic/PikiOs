#!/usr/bin/env bash

# This MUST be run before GUI and SERVICES

#unpack root in the end, so etc file are not overwritten, use root_init to unpack stuff that comes before
unpack /filesystem/root /