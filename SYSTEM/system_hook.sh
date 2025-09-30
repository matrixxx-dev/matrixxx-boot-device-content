#!/bin/bash

## as root:
## #############################################################################
CURRENT_PATH="${PWD}"
WORKING_PATH="/mnt-system/SYSTEM"

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
#pstree -alnpTuU > ".CHECK--pstree-after-system-autoconfig.txt"
#tree /run > ".CHECK--tree-run-after-system-autoconfig.txt"

## ---------------------------- ##
cd "${WORKING_PATH}" || return 1

## open virtual device
./storage_mount.sh

## start autostart_root
./autostart/autostart_root.sh

cd "${CURRENT_PATH}" || return 1
## ---------------------------- ##


## #############################################################################
## !!! no exit - its a sourced hook
# exit 0
