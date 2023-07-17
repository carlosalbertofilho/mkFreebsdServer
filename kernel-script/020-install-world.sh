#!/bin/sh

set -e

echo
echo Install custom kernel
echo

cd /usr/src
make installworld

echo
echo Snapshot install World
echo

echo "Enter you ZPOOL name: "
read -r answer
zfs snapshot -r "$answer"/ROOT/default@install-world

