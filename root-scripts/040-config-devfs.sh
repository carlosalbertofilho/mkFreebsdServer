echo
echo Configure /etc/devfs.rules
echo


{
echo     
echo [jail_with_bpf=5] 
echo add include $devfsrules_hide_all
echo add include $devfsrules_unhide_basic
echo add include $devfsrules_unhide_login
echo add path \'tun\*\' unhide
echo add path \'bpf\*\' unhide
echo add path zfs unhide
echo 
} >> /etc/devfs.rules