#!/bin/bash

# Additional packages in the ISO
PKGS="cryptsetup curl ddrescue gnupg2 gptfdisk efibootmgr lvm2 makepasswd mdadm mosh nano rsync wget vim"

yes y | xbps-install -Su xbps
yes y | xbps-install -Su
yes y | xbps-install -S git make
cd /root
[ ! -d 'void-mklive' ] && git clone 'https://github.com/void-linux/void-mklive.git'
cd 'void-mklive/'
make clean
make
./mklive.sh -a x86_64 -r 'https://mirrors.dotsrc.org/voidlinux/current' -p "$PKGS"
