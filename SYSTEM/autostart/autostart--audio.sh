#!/bin/bash

## as user:
## ########################################################################## ##
## audio configuration:
## PulseAudio: http://pulseaudio.org/
## PipeWire use pipewire-pulse daemon
## PipeWire use Session Manager wireplumber
##
## WirePlumber: https://wiki.archlinux.org/title/WirePlumber
## WirePlumber Control CLI: wpctl
## - wpctl status
##
## source: device that can emit digital audio stream to PulseAudio
##         (typically microphone, line input, HDMI capture card, ...
## sink:   device that can output digital audio stream from PulseAudio
##         (typically speaker signal, headphone/line output, HDMI output, ...)
##
## ########################################################################## ##
## https://github.com/mikeroyal/PipeWire-Guide
## ########################################################################## ##
SCRIPTNAME="$(basename "$0")"
INFO_FILE="/.INFO-autostart.md"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_write_infofile(){ sudo sh -c "echo '${1}' >> ${INFO_FILE}"; }

func_set_audio_device(){ # $type $mute_switch $volume
  local type mute_switch volume
  local device_array device alsa_type id
  type="$1"; mute_switch="$2"; volume="$3"

  case "${type}" in
    sink)
      alsa_type="alsa_output" ;;
    source)
      alsa_type="alsa_input" ;;
    *)
      echo "no known type: ${type}"
      exit 1 ;;
  esac

  readarray -t device_array \
    < <(pw-cli info all 2>/dev/null | grep "${alsa_type}")

  for device in "${device_array[@]}"
  do
    device="${device%\"*}"; device="${device#*\"}"
    id=$(pw-cli info "${device}" | head -n 1 | awk '{print $2}')
    func_write_infofile "${type}: ${device} (type:${type}; id: ${id})"
    echo "${type}: ${device} (id: ${id})"
    wpctl set-volume "${id}" "${volume}"                      ## set volume
    wpctl set-mute "${id}" "${mute_switch}"                   ## mute device
  done
}

func_wpctl_status(){
  wpctl status -k
  echo "## --------------------------------------------------------------- ##"
  wpctl status -n
  echo "## --------------------------------------------------------------- ##"
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_write_infofile "# Start of ${SCRIPTNAME}"

#func_wpctl_status

## "Device Type" "Mute Switch" "Volume in %"
## - Mute Switch    1|0|toggle
## - Volume in %    VOL[%][-/+]
func_set_audio_device "sink" "0" "75%"
func_set_audio_device "source" "1" "0%"

## -------------------------------------------------------------------------- ##
## pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
