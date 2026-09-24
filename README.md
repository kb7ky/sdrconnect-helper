# sdrconnect-helper
Setup instructions and scripts to setup Sdrplay SdrConnect environment for ham radio

## Definitions
* Ham Radio Digital Applications
  * flrig
  * fldigi
  * wsjt-x
  * freeDV
  * js8call
* Virtual Audio
  Path and components used to pass digital audio from a source to a destination.
* Virtual Comm Port
  Path and components used to pass digital data bi-directional between two applications.
* Sox
  Application used to bi-directionally pass data from one exposed /dev/ttysXXX device to another /dev/ttysYYY.
* SDRconnect
  Application from SDRplay used to control the RSPx SD hardware.
* flrig
  Application used to convert FLrig messages sent over the network to into a radio specific command.  In this use case, the SDRconnect message set is the same as the Kenwood TS-2000.

## Installation
* [this repository on github](https://github.com/kb7ky/sdrconnect-helper.git)
* [Virtual Cable](https://vb-audio.com/Cable/index.htm?gad_source=1&gad_campaignid=11369121960&gbraid=0AAAAADjKyE76t54EMrwPJNkmV0spKGOqM&gclid=Cj0KCQjw8c3VBhCsARIsAA_xJ91npopAZNu8eLQgLqXgs9Dfv8zNTvqqZEX-y-7LXETb_Sr0rH5pgbQaAjyqEALw_wcB)
* flrig
  <https://www.w1hkj.org>
* fldigi
  <https://www.w1hkj.org>
* [wsjt-x](https://wsjtx.github.io/wsjtx/index.html)
* [freeDV](https://freedv.org/download/)
* [js8call](https://js8call.com/downloads.html)

## Virtual Audio
## Virtual Comm Port
## Startup Procedure
* open Terminal and run buildVirtualComPort.sh
  Take note of SDRCATPORT and RIGCTLPORT.  These are required later...

* open Launcher and Start SDRconnect
  * do not click to start SDR
  * under Tool(Wrench), select Rig Control
  * make sure CAT Emulator is ON
  * make sure baud rate is 57600
  * set COM Port via pulldown to the SDRCATPORT value
  * Now you can click Green Arrow to start SDR

* open Launcher and Start flrig
  * if SDRCATPORT has changed, this will wait on initialization and you must kill the process and redo the config.
    * kill preferences
      * rm -rf ~/.flrig
    * Start flrig
      * Config -> Setup -> Ttansceiver
        * Radio TS-2000
        * baud rate 57600
        * You must enter the device port (RIGCTLPORT)... ex /dev/ttys007
        * click init
        * if this fails try init again
  * check that SDRconnect and flrig have the same frequency

* open Launcher and Start wsjt-x
