#! /bin/bash

## as user
## ########################################################################## ##
## generate the pandoc link to $XDG_DATA_HOME
##
## ########################################################################## ##
SCRIPTNAME="$(basename "$0")"
INFO_FILE="/.INFO-autostart.md"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_write_infofile(){ sudo sh -c "echo '${1}' >> ${INFO_FILE}"; }

## set pandoc environment
func_set_pandoc_environment(){
  local fstype dest source

  #sudo sh -c "echo PANDOC_DATA_DIR=$XDG_DATA_HOME/pandoc >> /etc/environment"
  fstype=$(df --output=fstype /mnt-system | tail -n 1)
  func_write_infofile "- /mnt-system fstype: $fstype"

  dest="$XDG_DATA_HOME/pandoc"
  source="$XDG_CONFIG_HOME/pandoc"
  func_write_infofile "- pandoc sourcepath: $source"

  case "${fstype}" in
    ext4) func_gen_pandoc_link "${dest}" "${source}" ;;
    vfat) func_copy_pandoc "${dest}" "${source}" ;;
  esac
}

## generate a directory link for pandoc
func_gen_pandoc_link(){ # linkpath="$1"; sourcepath="$2"
  local linkpath sourcepath
  linkpath="$1"; sourcepath="$2"
  [ -L "${linkpath}" ] && rm -f "${linkpath}"
  ln -s "${sourcepath}" "${linkpath}"
}

## copy pandoc environment to default pandoc path
func_copy_pandoc(){ # linkpath="$1"; sourcepath="$2"
  local linkpath sourcepath
  linkpath="$1"; sourcepath="$2"
  [ -e "${linkpath}" ] && rm -rf "${linkpath}"
  mkdir -p "${linkpath}"
  cp -ax "${sourcepath}"/* "${linkpath}"/
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_write_infofile ""; func_write_infofile "# Start of ${SCRIPTNAME}"
func_set_pandoc_environment

## -------------------------------------------------------------------------- ##
## pause:
#echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
