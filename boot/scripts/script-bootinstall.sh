#!/bin/bash

## ########################################################################## ##
##
## Setup booting from disk (USB, harddrive etc.)
##
## ########################################################################## ##
## DISCLAIMER:
## THIS IS EXPERIMENTAL SOFTWARE. USE AT YOUR OWN RISK. THE AUTHOR
## CAN NOT BE HELD LIABLE UNDER ANY CIRCUMSTANCES FOR DAMAGE TO HARDWARE OR
## SOFTWARE, LOST DATA, OR OTHER DIRECT OR INDIRECT DAMAGE RESULTING FROM THE
## USE OF THIS SOFTWARE.
## YOU ARE RESPONSIBLE FOR YOUR OWN COMPLIANCE WITH ALL APPLICABLE LAWS.
## ########################################################################## ##
## start script with sudo if necessary:
[ "$(id -u)" != "0" ] && exec sudo "$0" "$@"

LABLE_NAME="matrixxx"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_bootloader_installation(){  # mountpoint="$1"
  local mountpoint machine program cmd
  mountpoint="$1"
  syslinux_path="${mountpoint}/boot/syslinux"

  ## check bootloader
  [ -f "${syslinux_path}/ldlinux.sys" ] \
    && [ -f "${syslinux_path}/ldlinux.c32" ] && {
    echo "- Boot loader was installed."
    return 0
  }

  ## install bootloader
  program="./bin/extlinux"
  machine=$(uname -m)
  case "${machine}" in
    x86_64) program="${program}.64" ;;
    i686)   program="${program}.32"  ;;
    *)      program="" ;;
  esac

  [ -x "${program}" ] || {
    echo "${program} not found or not executable"
    return 1
  }
  cmd="${program} --install ${syslinux_path}"

  if ! eval "$cmd"; then
    echo "Error installing boot loader."
    echo "Read the errors above and press enter to exit..."
    read -r; exit 1
  fi

  echo "- Boot loader installation finished."
}

## -------------------------------------------------------------------------- ##
func_setup_MBR_and_bootflag(){ # device="$1"; partition="$2"
  local device partition
  device="$1"; partition="$2"

  local partition_no working_dir cmd
  working_dir="./bin"

  ## determine current device
  partition_no="${partition//*${device}/}"

  if [ "${device}" != "${partition}" ]; then

    ## write 'syslinux' MBR on the first block
    if [ -f "${working_dir}/mbr.bin" ]; then
      dd bs=440 count=1 conv=notrunc \
        if="${working_dir}/mbr.bin" of="${device}" 2>/dev/null
        echo "- 'syslinux' MBR installed"
    else
      echo "${working_dir}/mbr.bin does not exist!"
      exit 1
    fi

    ## set bootable flag
    parted "${device}" set "${partition_no}" boot on \
      && echo "- bootable flag is set"
    blockdev --flushbufs "${device}"
    func_sleep 3
  fi
}

## -------------------------------------------------------------------------- ##
func_set_partition_name(){ # partition="$1"; fs="$2"; name="$3"
  local device name fs
  partition="$1"; fs="$2"; name="$3"
  [ "${fs}" = "vfat" ] && {
    echo "set the name of partition ${partition}: ${name} (${fs})"
    fatlabel "${partition}" "${name}"
  }
  [ "${fs}" = "ext4" ] && {
    echo "set the name of partition ${partition}: ${name} (${fs})"
    e2label "${partition}" "${name}"
  }
}

## -------------------------------------------------------------------------- ##
func_sleep(){ # waiting_time
  local waiting_time
  waiting_time=$1
  echo "waiting time: ${waiting_time}s"
  sleep "${waiting_time}"
}

## -------------------------------------------------------------------------- ##
## check the current partition
func_check_partition_lsblk(){
  local field field_list partition file

  file="$(basename "$0").txt"; echo -n > "${file}"
  partition=$(df --output=source . | tail -n 1)

  echo "# current partition (lsblk): ${partition}"
  field_list=$(lsblk --list-column | awk '/^/{printf "%s ", $1}')
  for field in ${field_list}; do
    echo -n "   - ${field}: " | tee -a "${file}"
    lsblk --noheadings --output "${field}" "${partition}" | tee -a "${file}"
  done
}

## get info about the current partition
func_get_partition_info(){
  local field field_content field_list partition partition_info
  local device mountpoint fs

  partition=$(df --output=source . | tail -n 1)
  declare -A partition_info=(
  ["NAME"]=""
  ["PKNAME"]=""
  ["MOUNTPOINT"]=""
  ["ID"]=""
  ["FSTYPE"]=""
  ["UUID"]=""
  ["RO"]=""
  ["RM"]=""
  ["SIZE"]=""
  ["STATE"]=""
  )

  echo "# Das Skript befindet sich auf der Partition: ${partition}"
  for field in "${!partition_info[@]}"; do
    field_content=$(lsblk --noheadings --output "${field}" "${partition}")
    partition_info["${field}"]="${field_content}"
    #echo -n "   - ${field}: "; echo "${field_content}"
  done

  device="/dev/${partition_info[PKNAME]}"
  mountpoint="${partition_info[MOUNTPOINT]}"
  fs="${partition_info[FSTYPE]}"

  if [ "${partition_info[RM]}" = 0 ];then
    echo "- note: Laufwerk: ${device} ist ein internes Laufwerk"
  elif [ "${partition_info[RM]}" = 1 ];then
    echo "- note: Laufwerk: ${device} ist ein Wechselmedium"
  else
    echo "!!! nicht defifiniert - exit !!!"
    echo "Press enter to continue..."; read -r
    exit 1
  fi
  echo "        - das Skript befindet sich auf der Partition: ${partition}"
  echo "        - der Mountpoint der Partition ist: ${mountpoint}"
  echo "        - das Dateisystem der Partition ist: ${fs}"

  [ "${fs}" = "vfat" ] || [ "${fs}" = "ext4" ] || {
    echo ""; echo "Das Dateisystem ist nicht kompatibel für diesen Prozess"
    read -r; exit 1
  }

  echo ""; echo "Wollen Sie das Laufwerk: ${device} mit Syslinux bootbar machen?"
  sudo parted --script "${device}" unit % print
  echo "(j/n)"
  read -r input
  if [ "${input}" = "j" ]; then
    func_bootloader_installation "${mountpoint}" && \
    func_setup_MBR_and_bootflag "${device}" "${partition}" && \
    func_set_partition_name "${partition}" "${fs}" "${LABLE_NAME}"
    return 0
  else
    echo "Abbruch der gesamten Aktion!"; read -r; exit 1
  fi
}

func_process(){
  #func_check_partition_lsblk
  func_get_partition_info
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_process



## -------------------------------------------------------------------------- ##
## pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
