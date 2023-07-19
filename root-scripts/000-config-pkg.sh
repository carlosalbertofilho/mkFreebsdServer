#!/bin/sh

set -e


echo
echo Make Snapshot
echo


SNAPSHOT_NAME="default@BeforeConfig"

# Verifica se o snapshot já existe
if zfs list -t snapshot | grep -q "$SNAPSHOT_NAME"; then
    echo "O snapshot $SNAPSHOT_NAME já existe."
else
    echo "Enter you ZPOOL name: "
    read -r answer
    zfs snapshot -r "$answer"/ROOT/"$SNAPSHOT_NAME"
fi


echo
echo Packager update
echo

pkg update && pkg upgrade