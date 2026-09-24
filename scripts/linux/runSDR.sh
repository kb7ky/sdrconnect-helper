#!/bin/bash

# when SDRconnect ends - clean up
trap 'kill $(jobs -p) 2>/dev/null' EXIT

#  build virtual cable to route audio
~/bin/buildVirtualCable.sh

# Build virtual ComPort to route app requests TO SDRconnect
~/bin/buildVirtualComPort.sh &

# startup Audio Routing mixer
if pidof "qpwgraph" > /dev/null
then
    echo qpwgraph already running
else
    qpwgraph -a ~/patchbay/sdrconnect.qpwgraph &
fi

# start RigControl
cd /opt/rigcontrol
./RigControl &

# start SDRconnect
cd /opt/sdrconnect
./SDRconnect

