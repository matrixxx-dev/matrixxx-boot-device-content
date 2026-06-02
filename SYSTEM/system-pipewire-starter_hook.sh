#!/bin/bash

## #############################################################################
## start set the audio device configuration (by pipewire and)
## called by /usr/bin/pipewire-starter
## pipewire-starter is started by /etc/xdg/autostart/PipeWire.desktop
##
## ########################################################################## ##
## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_write_infofile(){ sudo sh -c "echo '${1}' >> ${INFO_FILE}"; }

func_choose_script(){ # script="$1; base_dir="$2"
  local script base_dir autostart_dir autostart_custom_dir
  script="$1"; base_dir="$2"
  autostart_custom_dir="${base_dir}/autostart_custom"
  autostart_dir="${base_dir}/autostart"
  if [ -x "${autostart_custom_dir}/${script}" ]; then
    "${autostart_custom_dir}/${script}"
  elif [ -x "${autostart_dir}/${script}" ]; then
    "${autostart_dir}/${script}"
  fi
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## audio configuration
sleep 2
func_choose_script "autostart--audio.sh" "/mnt-system/SYSTEM"

## #############################################################################
## !!! no exit - its a sourced hook
# exit 0
