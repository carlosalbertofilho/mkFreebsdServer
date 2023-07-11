#!/bin/sh

set -e

echo
echo Install custom kernel
echo

cd /usr/src
make installkernel KERNCONF=CUSTOM-KERNEL

echo
echo Snapshot install kernel
echo

echo "Enter you ZPOOL name: "
read -r answer
zfs snapshot -r "$answer"/ROOT/default@install-kernel

reboot -p
