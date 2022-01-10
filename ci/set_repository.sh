#!/bin/sh

REPO='https://mirrors.dotsrc.org/voidlinux/current'

# Set repository for xbps
rm -fr /etc/xbps.d
mkdir -p -m 755 /etc/xbps.d
echo "repository=$REPO" > /etc/xbps.d/repo.conf
