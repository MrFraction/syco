#!/bin/bash
#
# snort Start up the Snort Intrusion Detection System daemon #
# chkconfig: 2345 55 25
# description: Snort is a Open Source Intrusion Detection System
# This service starts up the snort daemon. #
# processname: snort
# pidfile: /var/run/snort_eth1.pid

### BEGIN INIT INFO
# Provides: snort
# Required-Start: $local_fs $network $syslog
# Required-Stop: $local_fs $syslog
# Should-Start: $syslog
# Should-Stop: $network $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start up the Snort Intrusion Detection System daemon
# Description: Snort is an application for Open Source Intrusion Detection.
#        This service starts up the Snort IDS daemon.
### END INIT INFO

# source function library
. /etc/rc.d/init.d/functions

# pull in sysconfig settings
[ -f /etc/sysconfig/snort ] && . /etc/sysconfig/snort

RETVAL=0
prog="snort"
lockfile=/var/lock/subsys/$prog

# Some functions to make the below more readable
SNORTD=/usr/sbin/snort
#OPTIONS="-A fast -b -d -D -i eth1 -u snort -g snort -c /etc/snort/snort.conf -l /var/log/snort"
#PID_FILE=/var/run/snort_eth1.pid

# Convert the /etc/sysconfig/snort settings to something snort can
# use on the startup line.
if [ "$ALERTMODE"X = "X" ]; then
    ALERTMODE=""
else
    ALERTMODE="-A $ALERTMODE"
fi

if [ "$USER"X = "X" ]; then
    USER="snort"
fi

if [ "$GROUP"X = "X" ]; then
    GROUP="snort"
fi

if [ "$BINARY_LOG"X = "1X" ]; then
    BINARY_LOG="-b"
else
    BINARY_LOG=""
fi

if [ "$LINK_LAYER"X = "1X" ]; then
    LINK_LAYER="-e"
else
    LINK_LAYER=""
fi

if [ "$CONF"X = "X" ]; then
    CONF="-c /etc/snort/snort.conf"
else
    CONF="-c $CONF"
fi

if [ "$INTERFACE"X = "X" ]; then
    INTERFACE="-i eth1"
    PID_FILE="/var/run/snort_eth1.pid"
else
    PID_FILE="/var/run/snort_$INTERFACE.pid"
    INTERFACE="-i $INTERFACE"
fi

if [ "$DUMP_APP"X = "1X" ]; then
    DUMP_APP="-d"
else
    DUMP_APP=""
fi

if [ "$NO_PACKET_LOG"X = "1X" ]; then
    NO_PACKET_LOG="-N"
else
    NO_PACKET_LOG=""
fi

if [ "$PRINT_INTERFACE"X = "1X" ]; then
    PRINT_INTERFACE="-I"
else
    PRINT_INTERFACE=""
fi

if [ "$PASS_FIRST"X = "1X" ]; then
    PASS_FIRST="-o"
else
    PASS_FIRST=""
fi

if [ "$LOGDIR"X = "X" ]; then
    LOGDIR=/var/log/snort
fi

# These are used by the 'stats' option
if [ "$SYSLOG"X = "X" ]; then
    SYSLOG=/var/log/messages
fi

if [ "$SECS"X = "X" ]; then
    SECS=5
fi

if [ ! "$BPFFILE"X = "X" ]; then
    BPFFILE="-F $BPFFILE"
fi

runlevel=$(set -- $(runlevel); eval "echo \$$#" )

start()
{
    [ -x $SNORTD ] || exit 5

    echo -n $"Starting $prog: "
    daemon --pidfile=$PID_FILE $SNORTD $ALERTMODE $BINARY_LOG \
            $LINK_LAYER $NO_PACKET_LOG $DUMP_APP -D $PRINT_INTERFACE \
            $INTERFACE -u $USER -g $GROUP $CONF -l $LOGDIR $PASS_FIRST $BPFFILE \
            $BPF && success || failure
    RETVAL=$?

    [ $RETVAL -eq 0 ] && touch $lockfile
    echo
    return $RETVAL
}

stop()
{
    echo -n $"Stopping $prog: "
    killproc $SNORTD
    if [ -e $PID_FILE ]; then
       chown -R $USER:$GROUP /var/run/snort_eth1.* &&
       rm -f /var/run/snort_eth1.pi*
    fi
    RETVAL=$?
    # if we are in halt or reboot runlevel kill all running sessions
    # so the TCP connections are closed cleanly
    if [ "x$runlevel" = x0 -o "x$runlevel" = x6 ] ; then
       trap  TERM
       killall $prog 2>/dev/null
       trap TERM
    fi
    [ $RETVAL -eq 0 ] && rm -f $lockfile
    echo
    return $RETVAL
}

restart() {
    stop
    start
}

rh_status() {
    status -p $PID_FILE $SNORTD
}

rh_status_q() {
    rh_status >/dev/null 2>&1
}

case "$1" in
    start)
       rh_status_q && exit 0
       start
       ;;
    stop)
       if ! rh_status_q; then
       rm -f $lockfile
       exit 0
       fi
       stop
       ;;
restart)
       restart
       ;;
status)
       rh_status
       RETVAL=$?
       if [ $RETVAL -eq 3 -a -f $lockfile ] ; then
       RETVAL=2
       fi
       ;;
*)
       echo $"Usage: $0 {start|stop|restart|status}"
       RETVAL=2
esac
exit $RETVAL
