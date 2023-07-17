#!/bin/sh
set -e

echo
echo Configure /etc/sysctl.conf
echo

{
echo \# SECURITY
echo   security.bsd.see_other_uids=0
echo   security.bsd.see_other_gids=0
echo   security.bsd.see_jail_proc=0
echo   security.bsd.unprivileged_read_msgbuf=0
echo   security.bsd.unprivileged_proc_debug=0
echo 
echo \# SECURITY/RANDOM PID
echo   kern.randompid=1
echo 
echo \# ANNOYING THINGS
echo   vfs.usermount=1
echo   kern.coredump=0
echo   hw.syscons.bell=0
echo   kern.vt.enable_bell=0
echo 
echo \# ZFS DELETE FUCKUP TRIM (DEFAULT: 64)
echo   vfs.zfs.vdev.trim_max_active=1
echo 
echo \# ZFS ARC TUNING
echo   vfs.zfs.arc.min=134217728
echo   vfs.zfs.arc.max=536870912
echo 
echo \# ZFS ARC FREE ENFORCE @ 1024 \* 1024 \* 3
echo   vfs.zfs.arc_free_target=3145728
echo   vfs.zfs.min_auto_ashift=12
echo 
echo \# JAILS/ALLOW UPGRADES IN JAILS
echo   security.jail.chflags_allowed=1
echo 
echo \# JAILS/ALLOW RAW SOCKETS
echo   security.jail.allow_raw_sockets=1
echo 
echo \# DESKTOP/INTERACTIVITY
echo   kern.sched.preempt_thresh=224
echo 
echo \# DESKTOP QUANTUM FOR TIMESHARE THREADS IN stathz TICKS (12) NomadBSD
echo   kern.sched.slice=3
echo 
echo \# SAMPLE RATE CONVERTER QUALITY (0=low .. 4=high) (1) NomadBSD
echo   hw.snd.feeder_rate_quality=3
echo 
echo \# PERFORMANCE/ALL SHARED MEMORY SEGMENTS WILL BE MAPPED TO UNPAGEABLE RAM
echo   kern.ipc.shm_use_phys=1
echo 
echo \# random PID
echo   kern.randompid=1
echo 
echo \# NETWORK/DO NOT SEND RST ON SEGMENTS TO CLOSED PORTS
echo   net.inet.tcp.blackhole=2
echo 
echo \# NETWORK/DO NOT SEND PORT UNREACHABLES FOR REFUSED CONNECTS
echo   net.inet.udp.blackhole=1
echo 
echo \# NETWORK/LIMIT ON SYN/ACK RETRANSMISSIONS (3)
echo   net.inet.tcp.syncache.rexmtlimit=0
echo 
echo \# NETWORK/USE TCP SYN COOKIES IF THE SYNCACHE OVERFLOWS (1)
echo   net.inet.tcp.syncookies=0
echo 
echo \# NETWORK/ASSIGN RANDOM ip_id VALUES (0)
echo   net.inet.ip.random_id=1
echo 
echo \# NETWORK/ENABLE SENDING IP REDIRECTS (1)
echo   net.inet.ip.redirect=0
echo 
echo \# NETWORK/ENABLE NAT
echo   net.inet.ip.forwarding=1
echo 
echo \# NETWORK/IGNORE ICMP REDIRECTS (0)
echo   net.inet.icmp.drop_redirect=1
echo 
echo \# NETWORK/DROP TCP PACKETS WITH SYN+FIN SET (0)
echo   net.inet.tcp.drop_synfin=1
echo 
echo \# NETWORK/RECYCLE CLOSED FIN_WAIT_2 CONNECTIONS FASTER (0)
echo   net.inet.tcp.fast_finwait2_recycle=1
echo 
echo \# NETWORK/CERTAIN ICMP UNREACHABLE MESSAGES MAY ABORT CONNECTIONS IN SYN_SENT (1)
echo   net.inet.tcp.icmp_may_rst=0
echo 
echo \# NETWORK/CONGESTION CONTROL
echo   net.inet.tcp.cc.algorithm=htcp
echo 
echo \# DEFAULT TO USE FOR THE TCP STACK
echo   net.inet.tcp.functions_default=bbr
echo
echo \# ENABLES ADAPTIVE BACKOFF ADJUSTMENT
echo   net.inet.tcp.cc.htcp.adaptive_backoff=1
echo
echo \# shares the same congestion control settings
echo   net.inet.tcp.functions_inherit_listen_socket_stack=0
echo 
echo \# ENABLING ROUND-TRIP TIME SCALING (rtt SCALING) IN THE htcp ALGORITHM 
echo   net.inet.tcp.cc.htcp.rtt_scaling=1
echo 
echo \# BY ENABLING THE tcp CONGESTION CONTROL ALGORITHM AS DEFINED IN rfc 6675. 
echo   net.inet.tcp.rfc6675_pipe=1
echo 
echo \# DISABLING THIS LOCAL TIMEOUT FOR tcp CONNECTIONS TERMINATED ON THE LOCAL SIDE
echo   net.inet.tcp.nolocaltimewait=1
echo 
echo \# MAXIMUM CONNECTION ACCEPTANCE QUEUE SIZE TO 1024
echo   kern.ipc.soacceptqueue=1024
echo 
echo \# SET TO AT LEAST 16MB FOR 10GE HOSTS
echo   kern.ipc.maxsockbuf=16777216
echo 
echo \# enable send/recv autotuning
echo   net.inet.tcp.sendbuf_auto=1
echo   net.inet.tcp.recvbuf_auto=1
echo
echo \# MAXIMUM SIZE OF THE SENDSPACE FOR tcp CONNECTIONS
echo   net.inet.tcp.sendspace=262144
echo   net.inet.tcp.sendbuf_max=16777216
echo   net.inet.tcp.sendbuf_inc=16384
echo   net.local.stream.sendspace=16384
echo
echo \# set this on test/measurement hosts
echo   net.inet.tcp.hostcache.expire=1
echo 
echo \# MAXIMUM RECEIVE SPACE SIZE (RECVSPACE) FOR tcp CONNECTIONS
echo   net.inet.tcp.recvspace=262144
echo   net.inet.tcp.recvbuf_max=16777216
echo   net.inet.tcp.recvbuf_inc=524288
echo   net.local.stream.recvspace=16384
echo 
echo \# MAXIMUM DATAGRAM SIZE FOR raw SOCKETS
echo   net.inet.raw.maxdgram=16384
echo   net.inet.raw.recvspace=16384
echo 
echo \# ADJUST THE ADDITIVE BOOST BEHAVIOR WHEN THERE IS NO PACKET LOSS IN THE NETWORK
echo   net.inet.tcp.abc_l_var=44
echo 
echo \# SETS THE INITIAL CONGESTION WINDOW SIZE IN SEGMENTS FOR tcp CONNECTIONS 
echo   net.inet.tcp.initcwnd_segments=44
echo 
echo \# DEFAULT VALUE FOR THE Maximum Segment Size (MSS) USED IN TCP CONNECTIONS.
echo   net.inet.tcp.mssdflt=1448
echo 
echo \# SETS THE MINIMUM VALUE OF THE mAXIMUM sEGMENT sIZE
echo   net.inet.tcp.minmss=524
echo 
echo \# MAXIMUM INTERRUPT QUEUE SIZE FOR INCOMING IP PACKETS. 
echo   net.inet.ip.intr_queue_maxlen=2048
echo 
echo \# MAXIMUM TASK QUEUE SIZE FOR NETWORK ROUTE PROCESSING.
echo   net.route.netisr_maxqlen=2048
echo 
} > /etc/sysctl.conf