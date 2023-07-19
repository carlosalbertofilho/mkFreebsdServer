#!/bin/sh

set -e


echo
echo Make Snapshot
echo

echo "Enter you ZPOOL name: "
read -r answer
zfs snapshot -r "$answer"/ROOT/default@BeforeConfig

echo
echo Packager update
echo

pkg update && sudo pkg upgrade