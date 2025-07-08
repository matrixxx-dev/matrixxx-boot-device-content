#! /bin/bash

## ########################################################################## ##
## mount storage loopdevice:
## ########################################################################## ##
MOUNTPOINT="$PWD/storage"
IMAGE="$PWD/storage.img"

## special handling for QEMU
## check on "rw" or "ro"
if [ -w "/mnt-system" ]; then
  OPTION=""
else
  OPTION="-o ro,noload"
  #OPTION="-o ro"
fi

## generate command
CMD="mount -o loop ${OPTION} ${IMAGE} ${MOUNTPOINT}"
[ "$(id -u)" != "0" ] && CMD="sudo ${CMD}"
#echo "${CMD}"
${CMD}

## ######################################################################### ##
exit 0
