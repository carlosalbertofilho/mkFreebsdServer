#!/bin/sh

set -e

echo
echo Make index of the Ports
echo

rm -fr  /usr/ports/*
git clone --depth 1 https://git.freebsd.org/ports.git /usr/ports -b 2023Q2
cd /usr/ports
make index

echo
echo Install portmaster and psearch
echo

cd ports-mgmt/portmaster && make install

cd /usr/ports
cd ports-mgmt/psearch && make install


echo
echo Copy config
echo

{
  echo hint.apic.0.disabled="1"  
} >> /boot/loader.conf
