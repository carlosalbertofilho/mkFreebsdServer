#!/bin/sh
set -e

echo
echo Configure SUDO
echo

pkg install -y cbsd

# start config
env workdir=/usr/jails /usr/local/cbsd/sudoexec/initenv