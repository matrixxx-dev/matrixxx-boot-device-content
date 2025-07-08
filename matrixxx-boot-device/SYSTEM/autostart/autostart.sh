#! /bin/bash

## as user:
## ########################################################################## ##
SYSTEM_DIR="/mnt-system/SYSTEM"
AUTOSTART_DIR="${SYSTEM_DIR}/autostart"
AUTOSTART_CUSTOM_DIR="${SYSTEM_DIR}/autostart_custom"
USER=$(id -nu)
HOME_DIR="/home/${USER}"

## INFO-FILE:
SCRIPTNAME="$(basename "$0")"
INFO_FILE="/.INFO-autostart.txt"
SEPERATOR="## ----------------------------------------------------------- ##"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_write_infofile(){ sudo sh -c "echo '${1}' >> ${INFO_FILE}"; }

func_choose_script(){ # $script
  local script
  script="$1"
  if [ -x "${AUTOSTART_CUSTOM_DIR}/${script}" ]; then
    func_write_infofile "   (custom version)"
    "${AUTOSTART_CUSTOM_DIR}/${script}"
  elif [ -x "${AUTOSTART_DIR}/${script}" ]; then
    func_write_infofile "   (base version)"
    "${AUTOSTART_DIR}/${script}"
  else
    func_write_infofile "   (default - no config script)"
  fi
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## INFO-FILE (start):
start=$(date +%s)
echo "*** START OF ${SCRIPTNAME}" | sudo tee /dev/kmsg
func_write_infofile "${SEPERATOR}"
func_write_infofile "Start of ${SCRIPTNAME}"
func_write_infofile "- current user: ${USER}"
func_write_infofile "- current path: ${PWD}"
func_write_infofile "- current pathenvironment: ${PATH}"
func_write_infofile "- script name: ${0}"
func_write_infofile "- script pid: $$"
func_write_infofile "- script ppid: $PPID"

## -------------------------------------------------------------------------- ##
## ## set storage directory
##   func_write_infofile "-- generate a symlink for storage"
## if [ -d "${SYSTEM_DIR}"/storage ]; then
##   func_write_infofile "   (${SYSTEM_DIR}/storage <- ${HOME_DIR}/StorageBox)"
##   ln -s "${SYSTEM_DIR}"/storage "${HOME_DIR}"/StorageBox
## else
##   func_write_infofile "   (${SYSTEM_DIR}/storage does not exist"
## fi

## -------------------------------------------------------------------------- ##
## adaptation of the display overlaying
func_write_infofile "-- configuration of 'xrandr'"
func_choose_script "autostart--xrandr.sh"

func_write_infofile "current configuration:"
func_write_infofile "$(xrandr --current)"

## -------------------------------------------------------------------------- ##
## audio configuration
#func_write_infofile "-- configuration of 'audio'"
#func_choose_script "autostart--audio.sh"

## -------------------------------------------------------------------------- ##
## debugging
#func_choose_script "autostart--debug.sh"

## -------------------------------------------------------------------------- ##
## INFO-FILE (finish):
echo "*** END OF ${SCRIPTNAME}" | sudo tee /dev/kmsg
func_write_infofile "- current path: ${PWD}"
end=$(date +%s); period=$((end - start))
func_write_infofile "- elapsed time: ${period} seconds"
func_write_infofile "End of ${SCRIPTNAME}"

## ########################################################################## ##
exit 0
