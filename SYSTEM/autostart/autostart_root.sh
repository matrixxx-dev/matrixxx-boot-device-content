#! /bin/sh

## as root:
## ########################################################################## ##
SYSTEM_DIR="/mnt-system"
USER_HOME="/home/xxx"

## INFO-FILE:
SCRIPTNAME="$(basename "$0")"
INFO_FILE="/.INFO-autostart.md"
SEPERATOR="## ----------------------------------------------------------- ##"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_init_infofile(){ sudo sh -c "echo -n '' > ${INFO_FILE}"; }
func_write_infofile(){ sudo sh -c "echo '${1}' >> ${INFO_FILE}"; }

getbootparam_system_dir(){ # parameter
read -r cmdline < /proc/cmdline
for i in ${cmdline}; do
  case "${i}" in
    "system_dir"=*) SYSTEM_DIR="${SYSTEM_DIR}/${i#*=}" ;;
  esac
done
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## INFO-FILE (start):
func_init_infofile
start=$(date +%s)
#echo "*** START OF ${SCRIPTNAME}" | tee /dev/kmsg
echo "*** START OF ${SCRIPTNAME}" > /dev/kmsg
func_write_infofile "${SEPERATOR}"
func_write_infofile "Start of ${SCRIPTNAME}"
func_write_infofile "- current user: ${USER}"
func_write_infofile "- current path: ${PWD}"
func_write_infofile "- command line: $(cat /proc/cmdline)"

## -------------------------------------------------------------------------- ##
getbootparam_system_dir
func_write_infofile "-- SYSTEM_DIR: ${SYSTEM_DIR}"

## -------------------------------------------------------------------------- ##
FILE="${USER_HOME}/.config/autostart/startup.desktop"
func_write_infofile "-- make sure file ${FILE} exists"
if [ -f "${FILE}" ]; then
  { func_write_infofile "-- -> exists"; }
else
  func_write_infofile "-- -> does not exists, so"
  FILE="./autostart/update_startup.tar.gz"
  if [ -f "${FILE}" ]; then
    func_write_infofile "-- -> extract ${FILE}"
    tar -zxf "${FILE}" -C / >/dev/null 2>&1
  else
    func_write_infofile "-- -> no local startup existend !!!"
  fi
fi

## -------------------------------------------------------------------------- ##
#func_write_infofile "-- generate new mountpoint"
#DIR="/media/knoppix"; [ -d "${DIR}" ] || mkdir -p "${DIR}"

## -------------------------------------------------------------------------- ##
func_write_infofile "-- show layer files"
FILE="${SYSTEM_DIR}/LAYER"
func_write_infofile "$(ls -la "${FILE}"* 2>/dev/null)"
#ls -la "${FILE}"* 2>/dev/null

## -------------------------------------------------------------------------- ##
## INFO-FILE (finish):
#echo "*** END OF ${SCRIPTNAME}" | tee /dev/kmsg
echo "*** END OF ${SCRIPTNAME}" > /dev/kmsg
func_write_infofile "- current path: ${PWD}"
end=$(date +%s); period=$((end - start))
func_write_infofile "- elapsed time: ${period} seconds"
func_write_infofile "End of ${SCRIPTNAME}"

## ########################################################################## ##
exit 0
