#!/bin/sh
set -e

echo
echo Configure firewall
echo


cat <<EOF> /usr/local/etc/pf.conf

set skip on lo0
block all
pass in proto tcp to port { 22 }
pass out proto { tcp udp } to port { 22 53 80 123 443 }
pass out inet proto icmp icmp-type { echoreq }

EOF