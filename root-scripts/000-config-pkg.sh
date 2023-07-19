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
    zfs snapshot -r "$answer"/ROOT/"$SNAPSHOT_NAME"
    if [ $? -eq 0 ]; then
        echo "Snapshot $SNAPSHOT_NAME criado com sucesso."
    else
        echo "Erro ao criar o snapshot $SNAPSHOT_NAME."
    fi
fi


echo "Enter you ZPOOL name: "
read -r answer
zfs snapshot -r "$answer"/ROOT/default@BeforeConfig

echo
echo Packager update
echo

pkg update && sudo pkg upgrade