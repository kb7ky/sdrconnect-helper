#!/bin/bash

if pactl list modules short | grep "VirtualCableSDR" > /dev/null
then
    echo "VirtualCableSDR already created"
else
    echo "Creating VirtualCableSDR"
    pactl load-module module-null-sink sink_name=VirtualCableSDR sink_properties=device.description=VirtualCable
fi

