#!/bin/sh

xbps-install --yes -Su xbps
xbps-install --yes -S libstdc++ bash liblz4 lzo kmod e2fsprogs
