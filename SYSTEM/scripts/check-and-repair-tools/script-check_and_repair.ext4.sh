#!/bin/bash

## ########################################################################## ##
## check and repair - ext4:
## ########################################################################## ##
#SCRIPT="ON"

DEVICE="sda1"
#DEVICE="sdb1"
#DEVICE="sdc1"
#DEVICE="sdd1"

CMD="sudo fsck /dev/${device}"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_check_device(){ # device="$1"; cmd="$2"
  local device cmd
  device="$1"; cmd="$2"
  echo "## ---------------------------------- ##"
  if findmnt -S "/dev/$device" ; then
    echo "--> /dev/$device is mounted"
  else
    echo "--> /dev/$device is NOT mounted"
    func_set_fsck_device "${device}" "${cmd}"
  fi
}

func_set_fsck_device(){ # device="$1"; cmd="$2"
  local device cmd
  device="$1"; cmd="$2"
  echo "## ---------------------------------- ##"
  ## Linux-Dateisysteme prüfen und reparieren
  ## fsck.vfat
  ##    -f     salvage unused chains to files
  ##    -v     verbose mode
  ##    -y,-a  automatically repair the filesystem
  cmd="sudo fsck.vfat -fv -y /dev/${device}"
  [ -z "${device}" ] || eval "${cmd}"
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
if [ "${SCRIPT}" != "ON" ]; then
  echo "'check and repair' must first be activated !!!"; read -r; exit 1
fi

## if no loop device do normal fsck
func_check_device "${DEVICE}" "${CMD}"

## -------------------------------------------------------------------------- ##
## pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
