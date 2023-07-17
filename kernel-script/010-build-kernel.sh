#!/bin/sh

set -e

echo
echo Update base and Install Git
echo

pkg update && sudo pkg upgrade -y
pkg install -y git



echo
echo Clone sources Ports and Kernel of the FreeBSD
echo


if [ -n "$(ls -A /usr/src)" ]; then
    rm -rf /usr/src
fi
sync
sleep 60
git clone -b releng/13.2 --depth 1 https://git.freebsd.org/src.git /usr/src 

#
# Define make options
#
cat <<EOF>> /etc/make.conf
# run the build and installation commands in a non-interactive way
 BATCH=yes

# native CPU type
 CPUTYPE?=native

# CPU optimations
 CFLAGS=-O2 -pipe -fno-strict-aliasing
 COPTFLAGS=-O2 -pipe -fno-strict-aliasing

# enable speed
 MALLOC_PRODUCTION="YES"
EOF

cat <<EOF>> /etc/src.conf
# NO DEBUG
  WITHOUT_ASSERT_DEBUG="ON"
EOF

cp ./kernel-script/NUTANIX /usr/src/sys/amd64/conf

cat <<EOF>> /usr/src/sys/amd64/conf/CUSTOM-KERNEL
# Extend Nutanix conf
include NUTANIX

ident CUSTOM-KERNEL

# Add enable IPFW and NAT
options  IPFIREWALL                    # enables IPFW
options  IPFIREWALL_VERBOSE            # enables logging for rules with log keyword
options  IPFIREWALL_VERBOSE_LIMIT=256  # limits number of logged packets per-entry

options  IPDIVERT                      # enables NATd Support
options  IPFIREWALL_NAT                # IPFW in-Kernel NAT support
options  LIBALIAS                      # required for in-Kernel NAT / replacement for NATd

# Activate the TCP BBR
makeoptions WITH_EXTRA_TCP_STACKS=1    # ADD EXTRA TCP STACKS
options RATELIMIT
options TCPHPTS

EOF

cd /usr/src

# Get CPUs core number
ncpu=$(sysctl -n hw.ncpu)

make -j"$ncpu" buildkernel KERNCONF=CUSTOM-KERNEL

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
