#! /bin/bash

## as user
## ########################################################################## ##
## adaptation of the display overlaying
##
## ########################################################################## ##
SCRIPTNAME="$(basename "$0")"
INFO_FILE="/.INFO-autostart.md"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_write_infofile(){ sudo sh -c "echo '${1}' >> ${INFO_FILE}"; }

func_prozess_xrandr(){
  local cmd_con cmd_discon interface_array_con interface_array_discon

  ## note: blank space required to distinguish " connected" from "disconnected"
  mapfile -t interface_array_con < <(xrandr | grep " connected")
  mapfile -t interface_array_discon < <(xrandr | grep "disconnected")

  cmd_con="xrandr --auto"
  for k in "${!interface_array_con[@]}"
  do
    interface_array_con[k]="${interface_array_con[k]// */}"
    cmd_con="${cmd_con} --output ${interface_array_con[k]} --pos 0x0"
  done

  cmd_discon="xrandr --auto"
  for k in "${!interface_array_discon[@]}"
  do
    interface_array_discon[k]="${interface_array_discon[k]// */}"
    cmd_discon="${cmd_discon} --output ${interface_array_discon[k]} --pos 0x0"
  done

  func_write_infofile "Connected Interfaces: ${interface_array_con[*]}"
  func_write_infofile "Disconnected Interfaces: ${interface_array_discon[*]}"

  ## TODO: - Mehr als 2 Bildschirme
  ##       - Reihenfolge der Bildschirme
  if [[ ${#interface_array_con[@]} -gt 1 ]]; then
    cmd_con="xrandr \
    --output ${interface_array_con[1]} \
    --mode 1920x1080 --pos 0x0 --rotate normal \
    --output ${interface_array_con[0]} \
    --mode 1920x1080 --pos 1920x0 --rotate normal"
  fi

  func_cmd_process "${cmd_con}"
#  func_cmd_process "${cmd_discon}"
  func_cmd_process "xrandr --output ${interface_array_con[1]} --primary"
}

func_cmd_process(){ # cmd
  local cmd output
  cmd="$1"
  echo "${cmd}"
  output=$(eval "${cmd}")
  echo "${output}"
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_write_infofile "# Start of ${SCRIPTNAME}"
func_prozess_xrandr

## -------------------------------------------------------------------------- ##
## pause:
#echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
