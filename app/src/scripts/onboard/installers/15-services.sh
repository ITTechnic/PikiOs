#!/usr/bin/env bash

#####################################################################
### setup services

echo "server time.nist.gov" >> /etc/ntp.conf
echo "server ntp.ubuntu.com" >> /etc/ntp.conf