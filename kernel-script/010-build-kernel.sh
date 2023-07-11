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
  echo \# Custom kernel config for NODEBUG
  echo \# Add enable IPFW and NAT
  echo
  echo include GENERIC-NODEBUG
  echo
  echo ident CUSTOM-KERNEL
  echo
  echo options  IPFIREWALL                    # enables IPFW
  echo options  IPFIREWALL_VERBOSE            # enables logging for rules with log keyword
  echo options  IPFIREWALL_VERBOSE_LIMIT=256  # limits number of logged packets per-entry
  echo options  IPFIREWALL_DEFAULT_TO_ACCEPT  # sets default policy to pass what is not explicitly denied
  echo
  echo options  IPDIVERT                      # enables NATd Support
  echo options  IPFIREWALL_NAT                # IPFW in-Kernel NAT support
  echo options  LIBALIAS                      # required for in-Kernel NAT / replacement for NATd
  echo

} >> /usr/src/sys/amd64/conf/CUSTOM-KERNEL

echo "Enter your ncpu: "
read -r answer
make -j"$answer" buildworld buildkernel KERNCONF=CUSTOM-KERNEL

echo
echo Reboot your system
echo
shutdown -r now
