#!/usr/bin/env bash

#make sure users don't run git with sudo, thus breaking permissions, by adding /root/bin to the
#default sudo path and placing a git wrapper script there that checks if it's run as root
sed -i "s@secure_path=\"@secure_path=\"/root/bin:@g" /etc/sudoers
chmod +x /root/bin/git