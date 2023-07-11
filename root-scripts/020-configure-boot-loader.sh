echo
echo Configure /boot/loader.conf
echo


{
echo 
echo # CONSOLE COMMON
echo   autoboot_delay=4       # OPT. '-1' => NO WAIT | OPT. 'NO' => INFINITE WAIT
echo 
echo # SECURITY
echo   security.bsd.allow_destructive_dtrace=0
echo 
echo # MODULES - BOOT
echo   aesni_load=\"YES\"
echo   geom_eli_load=\"YES\"
echo   cryptodev_load=\"YES\"
echo   zfs_load=\"YES\"
echo 
echo # "SRAT: Ignoring local APIC ID 4 (too high)" on KVM
echo   hint.apic.0.disabled=1  
echo 
echo # DISABLE /dev/diskid/* ENTRIES FOR DISKS
echo   kern.geom.label.disk_ident.enable=0
echo 
echo # DISABLE /dev/gptid/* ENTRIES FOR DISKS
echo   kern.geom.label.gptid.enable=0
echo 
echo # RACCT/RCTL RESOURCE LIMITS
echo   kern.racct.enable=1
echo 
echo # DISABLE ZFS PREFETCH
echo   vfs.zfs.prefetch_disable=1
echo 
echo # POWER MGMT / POWER OFF DEVICES WITHOUT ATTACHED DRIVER
echo   hw.pci.do_power_nodriver=3
echo 
} > /boot/loader.conf