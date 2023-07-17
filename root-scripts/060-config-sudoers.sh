#!/bin/sh
set -e

echo
echo Configure SUDO
echo

pkg install -y sudo 

# Configure sudo so users in the wheel group can elevate privileges
sed -ip 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /usr/local/etc/sudoers




