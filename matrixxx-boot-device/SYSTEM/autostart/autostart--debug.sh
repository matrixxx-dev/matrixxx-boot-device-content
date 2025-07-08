#! /bin/bash

## as user
## ########################################################################## ##
## debugging:
##
## ########################################################################## ##
## -------------------------------------------------------------------------- ##
## journalctl -p 3 -xb
##    -p 3 : filter logs for priority 3 (which is error)
##    -x   : provides additional information on the log (if available)
##     b   : since last boot (which is the current session)
## Priority   Code
## 0  emerg
## 1  alert
## 2  crit
## 3  err
## 4  warning
## 5  notice
## 6  info
## 7  debug
## -------------------------------------------------------------------------- ##

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
## save some infos to /mnt-system/SYSTEM
func_debug(){
  LOG_DATE=$(date +%F_%H_%M_%S)
  /usr/bin/inxi -c 0 -a -G > "/mnt-system/SYSTEM/graphics-${LOG_DATE}.txt"
  /usr/bin/dmesg > "/mnt-system/SYSTEM/dmesg-${LOG_DATE}.txt"
  /usr/bin/dmesg -l err > "/mnt-system/SYSTEM/dmesg_err-${LOG_DATE}.txt"
  /usr/bin/dmesg -l warn > "/mnt-system/SYSTEM/dmesg_warn-${LOG_DATE}.txt"
  sudo journalctl > "/mnt-system/SYSTEM/journalctl-${LOG_DATE}.txt"
  sudo journalctl -p 0 > "/mnt-system/SYSTEM/journalctl-emerg-${LOG_DATE}.txt"
  sudo journalctl -p 1 > "/mnt-system/SYSTEM/journalctl-alert-${LOG_DATE}.txt"
  sudo journalctl -p 2 > "/mnt-system/SYSTEM/journalctl-crit-${LOG_DATE}.txt"
  sudo journalctl -p 3 > "/mnt-system/SYSTEM/journalctl-err-${LOG_DATE}.txt"
  sudo journalctl -p 4 > "/mnt-system/SYSTEM/journalctl-warn-${LOG_DATE}.txt"
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_debug

## -------------------------------------------------------------------------- ##
## pause:
#echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
