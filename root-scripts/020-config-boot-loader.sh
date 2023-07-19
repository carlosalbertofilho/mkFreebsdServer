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

# "SRAT: Ignoring local APIC ID 4 (too high)" on KVM
 hint.apic.0.disabled=1  

# DISABLE /dev/diskid/* ENTRIES FOR DISKS
 kern.geom.label.disk_ident.enable=0

# DISABLE /dev/gptid/* ENTRIES FOR DISKS
 kern.geom.label.gptid.enable=0

# RACCT/RCTL RESOURCE LIMITS
 kern.racct.enable=1

# DISABLE ZFS PREFETCH
 vfs.zfs.prefetch_disable=1

# POWER MGMT / POWER OFF DEVICES WITHOUT ATTACHED DRIVER
 hw.pci.do_power_nodriver=3

EOF