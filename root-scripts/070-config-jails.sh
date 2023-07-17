#!/bin/sh
set -e

echo
echo Configure SUDO
echo

pkg install -y cbsd

# start config
cbsd initenv