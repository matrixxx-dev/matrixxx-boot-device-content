#!/bin/bash

## ########################################################################## ##
## mount virtual device:
## ########################################################################## ##
NAME="storage"

## -------------------------------------------------------------------------- ##
## FUNCTIONS
## -------------------------------------------------------------------------- ##
func_mount_image(){ # name="$1"
  local name mountpoint image option cmd
  name="$1"
  mountpoint="$PWD/${name}"
  image="$PWD/${name}.img"

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
func_mount_image "${NAME}"

## -------------------------------------------------------------------------- ##
## pause:
#echo "Press enter to continue..."; read -r

## ######################################################################### ##
exit 0
