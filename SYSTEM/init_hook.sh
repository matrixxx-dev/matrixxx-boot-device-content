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
## include user to selected groups
func_set_usermod(){
  local groupname username group_list
  username="xxx"
  group_list="audio cdrom disk lpadmin netdev scanner sudo video"
  group_list="${group_list} bluetooth render kvm"
  for groupname in ${group_list}
  do
    /bin/grep -E -i "^${groupname}" /etc/group >/dev/null 2>&1 \
      && sudo usermod -aG "${groupname}" "${username}"
  done
}

## -------------------------------------------------------------------------- ##
## set/adapt the polkit group of /etc/polkit-1/rules.d
func_set_polkit_group(){
  local gid
  gid=$(id -g polkitd)
  chgrp "${gid}" /etc/polkit-1/rules.d
  chown 0 /etc/polkit-1/rules.d
}

## -------------------------------------------------------------------------- ##
## set x-terminal-emulator
func_set_default_terminal(){
  local alternative terminal
  alternative="/etc/alternatives/x-terminal-emulator"
  terminal="/usr/bin/terminator"
  type -p ${terminal} >/dev/null 2>&1 || terminal="/usr/bin/lxterminal"
  type -p ${terminal} >/dev/null 2>&1 || terminal="/usr/bin/lxterm"
  if [ "${terminal}" != "/usr/bin/lxterm" ]; then
    sudo rm -f "${alternative}"
    sudo ln -s -T "${terminal}" "${alternative}"
  fi
}

## generate a starter directory link
func_gen_launcher_link(){
  [ -d /home/xxx/Starter/launcher ] \
    || ln -s /mnt-system/SYSTEM/launcher /home/xxx/Starter/launcher
}

## workaround to generate a directory link for freeplane
## has to be updated for every new version
func_gen_freeplane_link(){
  local version
  version="freeplane-1.13.2"
  [ -d /opt/freeplane ] || sudo ln -s /opt/"${version}" /opt/freeplane
}

## default-jdk/stable
func_configure_java(){
  ## - list installed version
  ## update-alternatives --list java
  ## update-alternatives --list javac
  ## update-alternatives --list jar
  ## update-alternatives --list jshell
  ## - Test installation:
  ## java -version
  ## jshell (end Ctrl + D)
  ##   Type in: System.out.println("Hello World");
  ## see also for interactive handling:
  ## sudo update-alternatives --display java
  ## sudo update-alternatives --config java
  local version machine arch cmd file priority
  version="21"
  machine=$(uname -m)
  case "${machine}" in
    x86_64) arch="amd64" ;;
    i686)   arch="i386" ;;
    *)      return 1 ;;
  esac

  ## - configure java, javac, jar, jshell installation
  ##   - Priorität ist eine Ganzzahl
  ##   - wobei höheren Zahlen im automatischen Modus höhere Priorität erzeugen
  for cmd in java javac jar jshell
  do
  file="/usr/lib/jvm/java-${version}-openjdk-${arch}/bin/${cmd}"
  [ -x "${file}" ] &&
  {
    #echo "${file}"
    priority=3000
    sudo update-alternatives --install /usr/bin/"${cmd}" "${cmd}" \
      "${file}" $priority >/dev/null 2>&1
  }
  done
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## determine the required time for the second init phase
## warning: INIT_TIME_START is referenced but not assigned.
# shellcheck disable=SC2154
init_time_period=$(($(date +%s) - INIT_TIME_START))
func_logging "- init time period (2) - elapsed time: ${init_time_period} seconds"

## -------------------------------------------------------------------------- ##
func_set_usermod
func_set_polkit_group
func_set_default_terminal
func_gen_launcher_link
func_gen_freeplane_link
func_configure_java

## -------------------------------------------------------------------------- ##
init_time_period=$(($(date +%s) - INIT_TIME_START))
func_logging "- init time period (3) - elapsed time: ${init_time_period} seconds"

## DEBUGGING:
#func_debugshell_test "Start init: ${init}"

## ########################################################################## ##
## !!! no exit - it is a sourced hook
