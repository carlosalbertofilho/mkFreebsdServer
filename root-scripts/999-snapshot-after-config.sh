#!/bin/sh

set -e

echo
echo Snapshot After Configuration
echo


echo "Enter you ZPOOL name: "
read -r answer
zfs snapshot -r "$answer"/ROOT/default@afterConfig

