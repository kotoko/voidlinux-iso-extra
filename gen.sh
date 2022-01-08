#!/bin/bash
set -euo pipefail

# Additional packages in the ISO
PKGS='bzip2 cryptsetup curl ddrescue gnupg2 git gptfdisk gzip efibootmgr lvm2 makepasswd mdadm mosh nano p7zip rsync wget vim unzip xz zip'

# Base packages required for livecd
# Source: https://github.com/void-linux/void-mklive/blob/master/build-x86-images.sh.in
BASE_PKGS='dialog cryptsetup lvm2 mdadm void-docs-browse grub-i386-efi grub-x86_64-efi'

# List of mirrors: https://docs.voidlinux.org/xbps/repositories/mirrors/
REPO='https://mirrors.dotsrc.org/voidlinux/current'

mkdir -p /etc/xbps.d
echo "repository=${REPO}" >> /etc/xbps.d/repo.conf
xbps-install --yes -Su xbps
xbps-install --yes -Su
xbps-install --yes -S git make
cd '/root'
[ ! -d 'void-mklive' ] && git clone -b master --single-branch --depth 1 'https://github.com/void-linux/void-mklive.git' 'void-mklive'
cd 'void-mklive/'
make clean
make
./mklive.sh -a 'x86_64' -r "${REPO}" -p "${BASE_PKGS} ${PKGS}"
