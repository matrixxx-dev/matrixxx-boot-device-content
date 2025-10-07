#!/bin/bash

## ########################################################################## ##
## mount virtual device:
## ########################################################################## ##
MOUNTPOINT_NAME="storage"
STORAGE_NAME="storage"

## -------------------------------------------------------------------------- ##
## FUNCTIONS
## -------------------------------------------------------------------------- ##
func_mount_image(){ # name="$1"; mountpoint_name="$2"
  local name mountpoint image option cmd
  image="$PWD/$1.img"; mountpoint="$PWD/$2"

  ## special handling for QEMU
  ## check on "rw" or "ro"
  if [ -w "/mnt-system" ]; then
    option=""
  else
    option="-o ro,noload"
    #option="-o ro"
  fi

  [ -d "${mountpoint}" ] || mkdir -p "${mountpoint}"
  cmd="mount -o loop ${option} ${image} ${mountpoint}"
  [ "$(id -u)" != "0" ] && cmd="sudo ${cmd}"
  #echo "${cmd}"
  ${cmd}
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_mount_image "${STORAGE_NAME}" "${MOUNTPOINT_NAME}"

## -------------------------------------------------------------------------- ##
## pause:
#echo "Press enter to continue..."; read -r

## ######################################################################### ##
exit 0
