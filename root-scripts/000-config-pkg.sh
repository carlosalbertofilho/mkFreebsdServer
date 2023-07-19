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
    echo "Enter your ZPOOL name: "
    read -r answer
    zfs snapshot -r "$answer"/ROOT/"$SNAPSHOT_NAME"
    echo "Snapshot $SNAPSHOT_NAME criado em $answer/ROOT."
fi

echo
echo Package update
echo

# Atualiza os pacotes automaticamente sem interação do usuário
pkg update
pkg upgrade -y

echo "Atualização de pacotes concluída."
