#!/bin/sh
set -e

echo
echo Configure /boot/loader.conf
echo


cat <<EOF>> /boot/loader.conf
# CONSOLE COMMON
 autoboot_delay=4       # OPT. '-1' => NO WAIT | OPT. 'NO' => INFINITE WAIT

# SECURITY
 security.bsd.allow_destructive_dtrace=0

# MODULES - BOOT
 aesni_load="YES"
 geom_eli_load="YES"
 cryptodev_load="YES"
 zfs_load="YES"

# TCP STACK
 cc_htcp_load="YES"

# RACCT/RCTL RESOURCE LIMITS
 kern.racct.enable=1

EOF