#!/bin/sh
set -e

echo
echo Configure /etc/pf.conf
echo

touch /etc/pf.conf

{
echo
echo set skip on lo0
echo block all
echo pass in proto tcp to port { 22 }
echo pass out proto { tcp udp } to port { 22 53 80 123 443 }
echo pass out inet proto icmp icmp-type { echoreq }
echo 
} > /etc/pf.conf