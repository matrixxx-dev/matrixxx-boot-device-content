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

  local file_list file
  echo "Desktop Environment: ${DESKTOP}" | sudo tee /dev/kmsg
  file_list=""
  case "${DESKTOP}" in
    lxde)
      file_list="${file_list} /etc/xdg/autostart/lxpolkit.desktop"
      file_list="${file_list} /etc/xdg/autostart/lxqt-desktop.desktop"
      #file_list="${file_list} /etc/xdg/autostart/nm-applet.desktop"
      file_list="${file_list} /etc/xdg/autostart/nm-tray-autostart.desktop"
      ;;
    lxqt)
      ;;
    xfce4)
      ;;
    *)
      ;;
  esac

  file_list="${file_list} /etc/xdg/autostart/orca-autostart.desktop"
  file_list="${file_list} /etc/xdg/autostart/org.gnome.SettingsDaemon.DiskUtilityNotify.desktop"
  file_list="${file_list} /etc/xdg/autostart/geoclue-demo-agent.desktop"
  file_list="${file_list} /etc/xdg/autostart/kglobalacceld.desktop"
  file_list="${file_list} /etc/xdg/autostart/pkcs11-register.desktop"
  file_list="${file_list} /etc/xdg/autostart/baloo_file.desktop"
  file_list="${file_list} /etc/xdg/autostart/org.gnome.DejaDup.Monitor.desktop"
  file_list="${file_list} /etc/xdg/autostart/xdg-user-dirs-kde.desktop"
  file_list="${file_list} /etc/xdg/autostart/xdg-user-dirs.desktop"

  ## 'thunderbird account & settings', 'chromium' and 'brave-browser'
  ## - remove customizations if the program is not installed at all.
  type -p thunderbird \
    || file_list="${file_list} $HOME/.local/share/applications/my-thunderbird-accounts.desktop"
  type -p chromium \
    || file_list="${file_list} /usr/share/applications/chromium.desktop"
  type -p brave-browser ||  {
    file_list="${file_list} /usr/share/applications/brave-browser.desktop"
    file_list="${file_list} /usr/share/applications/com.brave.Browser.desktop"
  }

  ## remove files from 'file list'
  for file in ${file_list}; do
    func_echo "- check file: ${file}"
    [ -f "${file}" ] && { sudo rm -f "${file}"; func_echo "  - now deleted";}
  done

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
