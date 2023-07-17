#!/bin/sh

set -e

echo
echo Clone sources Ports and Kernel of the FreeBSD
echo

rm -fr /usr/src/* 
git clone --depth 1 https://git.freebsd.org/src.git /usr/src -b releng/13.2


touch /etc/make.conf
{
  echo
  echo \# run the build and installation commands in a non-interactive way
  echo BATCH=yes
  echo
  echo \# native CPU type
  echo CPUTYPE?=native
  echo \# CPU optimations
  echo CFLAGS=-O2 -pipe -fno-strict-aliasing
  echo COPTFLAGS=-O2 -pipe -fno-strict-aliasing
  echo \# enable speed
  echo MALLOC_PRODUCTION=\"YES\"
} >> /etc/make.conf

touch /etc/src.conf
{
    echo \# NO DEBUG
    echo WITHOUT_ASSERT_DEBUG=\"ON\"
} >> /etc/src.conf

cd /usr/src
touch /usr/src/sys/amd64/conf/CUSTOM-KERNEL
{
  echo
  echo include GENERIC
  echo
  echo ident CUSTOM-KERNEL
  echo
  echo \# Add enable IPFW and NAT
  echo options  IPFIREWALL                    # enables IPFW
  echo options  IPFIREWALL_VERBOSE            # enables logging for rules with log keyword
  echo options  IPFIREWALL_VERBOSE_LIMIT=256  # limits number of logged packets per-entry
  echo
  echo options  IPDIVERT                      # enables NATd Support
  echo options  IPFIREWALL_NAT                # IPFW in-Kernel NAT support
  echo options  LIBALIAS                      # required for in-Kernel NAT / replacement for NATd
  echo
  echo \# Activate the TCP BBR
  echo makeoptions WITH_EXTRA_TCP_STACKS=1    # ADD EXTRA TCP STACKS
  echo options RATELIMIT
  echo options TCPHPTS

} >> /usr/src/sys/amd64/conf/CUSTOM-KERNEL

make -j"${sysctl -n hw.ncpu}" buildworld buildkernel KERNCONF=CUSTOM-KERNEL

echo
echo Install custom kernel
echo

cd /usr/src
make installkernel KERNCONF=CUSTOM-KERNEL

echo
echo Snapshot install kernel
echo

echo "Enter you ZPOOL name: "
read -r answer
zfs snapshot -r "$answer"/ROOT/default@install-kernel

reboot -p
