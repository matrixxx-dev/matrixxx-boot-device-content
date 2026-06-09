#!/bin/sh

## ########################################################################## ##
## "last but not least" of the initramfs script
##
## ########################################################################## ##
# shellcheck disable=SC3043  ## In POSIX sh, 'local' is undefined
# shellcheck disable=SC3045  ## In POSIX sh, type -p is undefined

func_logging "# initramfs log: init_hook to ${INIT_INFO_FILE}"
func_logging "- file: [${HOOK_SCRIPT}]"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## determine the required time for the second init phase
## warning: INIT_TIME_START is referenced but not assigned.
# shellcheck disable=SC2154
init_time_period=$(($(date +%s) - INIT_TIME_START))
func_logging "- init time period (2) - elapsed time: ${init_time_period} seconds"

## -------------------------------------------------------------------------- ##

## -------------------------------------------------------------------------- ##

init_time_period=$(($(date +%s) - INIT_TIME_START))
func_logging "- init time period (3) - elapsed time: ${init_time_period} seconds"

## DEBUGGING:
#func_debugshell_test "Start init: ${init}"

## ########################################################################## ##
## !!! no exit - it is a sourced hook
