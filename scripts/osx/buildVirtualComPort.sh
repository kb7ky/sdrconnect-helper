#!/bin/bash
# OSX version
# NOTE: socat and rigctld spawned by this script

TMPDIR=/var/tmp
TMPFILE=/var/tmp/dx
DEVB4=${TMPDIR}/devb4
DEVAFTER=${TMPDIR}/devafter
LINKDIR=/var/tmp
DEVICESDR=
DEVICESDRCOMPORT=

# build the pty's 
# make sure socat is running

if pgrep -x "socat" > /dev/null
then
    echo "socat running"
else
    echo "socat not running"
    pkill socat
    pkill rigctld
    rm -rf ~/.flrig
    rm ${LINKDIR}/ttySDR ${LINKDIR}/ttySDRCOMPORT
fi

if [ -c "${LINKDIR}/ttySDR" ]
then
    # echo "${LINKDIR}/ttySDR already exists"
    DEVICESDR=`realpath ${LINKDIR}/ttySDR`
    DEVICECOMPORT=`realpath ${LINKDIR}/ttySDRCOMPORT`
    echo "SDRCATPORT ${DEVICESDR} RIGCTLPORT ${DEVICECOMPORT}"
else
    echo "Creating PTY"
    ls -1 /dev/ttys00* > ${DEVB4}
    socat -d pty,mode=660,raw,echo=0 pty,mode=660,raw,echo=0 &
    sleep 1
    ls -1 /dev/ttys00* > ${DEVAFTER}
    diff ${DEVB4} ${DEVAFTER} | grep /dev | cut -f2 -d' ' >  ${TMPFILE}
    while read a
      do
         if [ -z "${DEVICESDR}" ]
         then
           DEVICESDR=$a
           ln -s $a ${LINKDIR}/ttySDR
         else
           DEVICECOMPORT=$a
           ln -s $a ${LINKDIR}/ttySDRCOMPORT
         fi
      done < ${TMPFILE}
    echo "SDRCATPORT ${DEVICESDR} RIGCTLPORT ${DEVICECOMPORT}"
fi

# start rigctld
if pgrep "rigctld" > /dev/null
then
    echo "rigctld running"
else
    echo "starting rigctld"
    rigctld -r ${LINKDIR}/ttySDRCOMPORT -s 57600 -m 2014 &
fi


