#!/bin/bash
# NOTE: socat spawned by this script

DEVICE="/dev/ttySDR"

# build the pty's 
if [ -c "$DEVICE" ]
then
    echo "/dev/ttySDR already exists"
else
    echo "Creating /dev/ttySDR"
    sudo socat pty,link=/dev/ttySDR,group=dialout,mode=660,raw,echo=0 pty,link=/dev/ttySDRCOMPORT,group=dialout,mode=660,raw,echo=0 &
fi

# start rigctld
if pidof "rigctld" > /dev/null
then
    echo "rigctld running"
else
    rigctld -r /dev/ttySDRCOMPORT -s 57600 -m 2014 &
fi


