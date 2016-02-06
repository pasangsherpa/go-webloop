#!/bin/bash
set -e

DISPLAY=:0.0
XVFB=/usr/bin/Xvfb
XVFBARGS="$DISPLAY -ac -screen 0 1024x768x16 +extension RANDR"
PIDFILE="/var/xvfb.pid"

echo "export DISPLAY=$DISPLAY" >> $HOME/.bashrc

/sbin/start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background --exec $XVFB -- $XVFBARGS
sleep 1

$APP