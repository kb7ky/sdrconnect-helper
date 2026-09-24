#!/bin/bash
# OSX startup SDRconnect

./buildVirtualComPort.sh
sleep 5

open /Applications/SDRconnect.app

echo "Start SDR and then Start FLRig"

