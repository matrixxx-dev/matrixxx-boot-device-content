#!/bin/bash

## #############################################################################
#echo "**** $0 reached" > /dev/kmsg            # does not work
#echo "***** $0 reached" | sudo tee /dev/kmsg  # ok

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
## check desktop
func_check_desktop(){
  [ -f /etc/sysconfig/desktop ] || return 1
  . /etc/sysconfig/desktop

  echo "Desktop Environment: ${DESKTOP}" | sudo tee /dev/kmsg
  case "${DESKTOP}" in
    lxde)
      ;;
    lxqt)
      ;;
    xfce4)
      ;;
    *)
      ;;
  esac

  ## remove /usr/share/templates content
  sudo rm -rf /usr/share/templates/*
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_echo ""; func_echo "## process Xsession_hook.sh:"
func_check_desktop

## #############################################################################
## !!! no exit - its a sourced hook
# exit 0
