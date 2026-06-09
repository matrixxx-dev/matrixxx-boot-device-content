#!/bin/sh
HOOK_SCRIPT="/mnt-system/SYSTEM/init_hook.sh"
[ -f  "${HOOK_SCRIPT}" ] && . "${HOOK_SCRIPT}"
