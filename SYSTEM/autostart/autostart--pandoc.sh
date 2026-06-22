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
## generate a directory link for pandoc
func_gen_pandoc_link(){
  local linkpath sourcepath
  linkpath="$XDG_DATA_HOME/pandoc"
  sourcepath="$XDG_CONFIG_HOME/pandoc"
  func_write_infofile "- pandoc sourcepath: $sourcepath"
  [ -L "${linkpath}" ] && rm -f "${linkpath}"
  ln -s "${sourcepath}" "${linkpath}"
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_write_infofile ""; func_write_infofile "# Start of ${SCRIPTNAME}"
func_gen_pandoc_link

## -------------------------------------------------------------------------- ##
## pause:
#echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
