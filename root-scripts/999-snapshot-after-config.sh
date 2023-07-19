#!/bin/sh

set -e

echo
echo Snapshot After Configuration
echo

SNAPSHOT_NAME="default@AfterConfig"

# Verifica se o snapshot já existe
if zfs list -t snapshot | grep -q "$SNAPSHOT_NAME"; then
    echo "O snapshot $SNAPSHOT_NAME já existe."
else
    echo "Enter you ZPOOL name: "
    read -r answer
    zfs snapshot -r "$answer"/ROOT/"$SNAPSHOT_NAME"
fi
