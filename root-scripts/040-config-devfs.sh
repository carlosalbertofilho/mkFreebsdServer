#!/bin/sh
set -e

echo
echo Configure /etc/devfs.rules
echo


cat <<EOF> /etc/devfs.rules  
# jail_with_bpf
  [server=5]
  add include $devfsrules_hide_all
  add include $devfsrules_unhide_basic
  add include $devfsrules_unhide_login
  add path \'tun\*\' unhide
  add path \'bpf\*\' unhide
  add path zfs unhide

EOF