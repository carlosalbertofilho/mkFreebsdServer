#!/bin/sh
set -e

echo
echo Configure /etc/sysctl.conf
echo

cat <<EOF>> /etc/sysctl.conf
# SECURITY
 security.bsd.see_other_uids=0
 security.bsd.see_other_gids=0
 security.bsd.see_jail_proc=0
 security.bsd.unprivileged_read_msgbuf=0
 security.bsd.unprivileged_proc_debug=0

# SECURITY/RANDOM PID
 kern.randompid=1

# ANNOYING THINGS
 vfs.usermount=1
 kern.coredump=0
 hw.syscons.bell=0
 kern.vt.enable_bell=0

# ZFS DELETE FUCKUP TRIM (DEFAULT: 64)
 vfs.zfs.vdev.trim_max_active=1

# ZFS ARC TUNING
 vfs.zfs.arc.min=134217728
 vfs.zfs.arc.max=536870912

# ZFS ARC FREE ENFORCE @ 1024 \* 1024 \* 3
 vfs.zfs.arc_free_target=3145728
 vfs.zfs.min_auto_ashift=12

# JAILS/ALLOW UPGRADES IN JAILS
 security.jail.chflags_allowed=1

# JAILS/ALLOW RAW SOCKETS
 security.jail.allow_raw_sockets=1

# DESKTOP/INTERACTIVITY
 kern.sched.preempt_thresh=224

# DESKTOP QUANTUM FOR TIMESHARE THREADS IN stathz TICKS (12) NomadBSD
 kern.sched.slice=3

# SAMPLE RATE CONVERTER QUALITY (0=low .. 4=high) (1) NomadBSD
 hw.snd.feeder_rate_quality=3

# PERFORMANCE/ALL SHARED MEMORY SEGMENTS WILL BE MAPPED TO UNPAGEABLE RAM
 kern.ipc.shm_use_phys=1

# random PID
 kern.randompid=1

# NETWORK/DO NOT SEND RST ON SEGMENTS TO CLOSED PORTS
 net.inet.tcp.blackhole=2

# NETWORK/DO NOT SEND PORT UNREACHABLES FOR REFUSED CONNECTS
 net.inet.udp.blackhole=1

# NETWORK/LIMIT ON SYN/ACK RETRANSMISSIONS (3)
 net.inet.tcp.syncache.rexmtlimit=0

# NETWORK/USE TCP SYN COOKIES IF THE SYNCACHE OVERFLOWS (1)
 net.inet.tcp.syncookies=0

# NETWORK/ASSIGN RANDOM ip_id VALUES (0)
 net.inet.ip.random_id=1

# NETWORK/ENABLE SENDING IP REDIRECTS (1)
 net.inet.ip.redirect=0

# NETWORK/ENABLE NAT
 net.inet.ip.forwarding=1

# NETWORK/IGNORE ICMP REDIRECTS (0)
 net.inet.icmp.drop_redirect=1

# NETWORK/DROP TCP PACKETS WITH SYN+FIN SET (0)
 net.inet.tcp.drop_synfin=1

# NETWORK/RECYCLE CLOSED FIN_WAIT_2 CONNECTIONS FASTER (0)
 net.inet.tcp.fast_finwait2_recycle=1

# NETWORK/CERTAIN ICMP UNREACHABLE MESSAGES MAY ABORT CONNECTIONS IN SYN_SENT (1)
 net.inet.tcp.icmp_may_rst=0

# NETWORK/CONGESTION CONTROL
 net.inet.tcp.cc.algorithm=htcp

# DEFAULT TO USE FOR THE TCP STACK
 net.inet.tcp.functions_default=bbr

# ENABLES ADAPTIVE BACKOFF ADJUSTMENT
 net.inet.tcp.cc.htcp.adaptive_backoff=1

# shares the same congestion control settings
 net.inet.tcp.functions_inherit_listen_socket_stack=0

# ENABLING ROUND-TRIP TIME SCALING (rtt SCALING) IN THE htcp ALGORITHM 
 net.inet.tcp.cc.htcp.rtt_scaling=1

# BY ENABLING THE tcp CONGESTION CONTROL ALGORITHM AS DEFINED IN rfc 6675. 
 net.inet.tcp.rfc6675_pipe=1

# DISABLING THIS LOCAL TIMEOUT FOR tcp CONNECTIONS TERMINATED ON THE LOCAL SIDE
 net.inet.tcp.nolocaltimewait=1

# MAXIMUM CONNECTION ACCEPTANCE QUEUE SIZE TO 1024
 kern.ipc.soacceptqueue=1024

# SET TO AT LEAST 16MB FOR 10GE HOSTS
 kern.ipc.maxsockbuf=16777216

# enable send/recv autotuning
 net.inet.tcp.sendbuf_auto=1
 net.inet.tcp.recvbuf_auto=1

# MAXIMUM SIZE OF THE SENDSPACE FOR tcp CONNECTIONS
 net.inet.tcp.sendspace=262144
 net.inet.tcp.sendbuf_max=16777216
 net.inet.tcp.sendbuf_inc=16384
 net.local.stream.sendspace=16384

# set this on test/measurement hosts
 net.inet.tcp.hostcache.expire=1

# MAXIMUM RECEIVE SPACE SIZE (RECVSPACE) FOR tcp CONNECTIONS
 net.inet.tcp.recvspace=262144
 net.inet.tcp.recvbuf_max=16777216
 net.inet.tcp.recvbuf_inc=524288
 net.local.stream.recvspace=16384

# MAXIMUM DATAGRAM SIZE FOR raw SOCKETS
 net.inet.raw.maxdgram=16384
 net.inet.raw.recvspace=16384

# ADJUST THE ADDITIVE BOOST BEHAVIOR WHEN THERE IS NO PACKET LOSS IN THE NETWORK
 net.inet.tcp.abc_l_var=44

# SETS THE INITIAL CONGESTION WINDOW SIZE IN SEGMENTS FOR tcp CONNECTIONS 
 net.inet.tcp.initcwnd_segments=44

# DEFAULT VALUE FOR THE Maximum Segment Size (MSS) USED IN TCP CONNECTIONS.
 net.inet.tcp.mssdflt=1448

# SETS THE MINIMUM VALUE OF THE mAXIMUM sEGMENT sIZE
 net.inet.tcp.minmss=524

# MAXIMUM INTERRUPT QUEUE SIZE FOR INCOMING IP PACKETS. 
 net.inet.ip.intr_queue_maxlen=2048

# MAXIMUM TASK QUEUE SIZE FOR NETWORK ROUTE PROCESSING.
 net.route.netisr_maxqlen=2048
 
EOF