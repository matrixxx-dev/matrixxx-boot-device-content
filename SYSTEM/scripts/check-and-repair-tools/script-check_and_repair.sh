#!/bin/bash

## ########################################################################## ##
## check and repair - ext4 patition:
## ########################################################################## ##
#SCRIPT="ON"

PARTITION="sda1"
#PARTITION="sdb1"
#PARTITION="sdc1"
#PARTITION="sdd1"
#PARTITION="sde1"
#PARTITION="nvme0n1p1"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_check_partition(){ # partition="$1"
  local partition cmd device fs
  partition="$1"; cmd="$2"
  if [ -z "${partition}" ]; then
    echo "no partition is selected !!!"; return 1
  fi
  device="/dev/${partition}"
  echo "## ---------------------------------- ##"
  if findmnt -S "${device}" ; then
    echo "--> ${device} is mounted - don't execute fsck"
  else
    echo "--> ${device} is not mounted - execute fsck"
    ## get fs
    ## lsblk -A -n -o FSTYPE ${device}
    ##    -A, --noempty        don't print empty devices
    ##    -n, --noheadings     don't print headings
    ##    -o, --output <list>  output columns (see --list-columns)
    fs=$(lsblk -A -n -o FSTYPE "${device}")

    ## check and repair a Linux filesystem
    case "${fs}" in
      ext4)
        cmd="sudo fsck /dev/${partition}"
        ;;
      vfat)
        ## fsck.vfat
        ##    -f     salvage unused chains to files
        ##    -v     verbose mode
        ##    -y,-a  automatically repair the filesystem
        ##
        cmd="sudo fsck.vfat -fv -y /dev/${partition}"
        ;;
      *)
        echo "filesystemtype ${fs} is not supported by this script !!!"
        return 1
        ;;
    esac

  echo "## ---------------------------------- ##"
  echo "CMD: ${cmd} FS: ${fs}"
  eval "${cmd}"
  fi
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
if [ "${SCRIPT}" != "ON" ]; then
  echo "'check and repair' must be activated first !!!"
else
  ## process:
  func_check_partition "${PARTITION}"
fi

## -------------------------------------------------------------------------- ##
## pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
