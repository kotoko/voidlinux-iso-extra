#!/bin/sh

xbps-install --yes -Su xbps
xbps-install --yes -S gcc bash liblz4 lzo kmod e2fsprogs
