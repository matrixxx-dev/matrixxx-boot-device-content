#!/bin/bash
HOOK_SCRIPT="/mnt-system/SYSTEM/system_hook.sh"
[ -f  "${HOOK_SCRIPT}" ] && . "${HOOK_SCRIPT}"
