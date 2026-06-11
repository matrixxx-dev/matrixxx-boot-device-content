---
defaults: github-markdown
toc: false
---
<!-- *********************************************************************** -->
# Stucture of configuration scripts:

## initramfs (kernel init script)
- called by kernel (declared in syslinux configuation file)
- splited in two parts
  - `/init` (mounted the boot device)
  - `/init_main` (possibly replaced by `init_main_hook.sh` script)

#### *hook:* init_main_hook.sh
- will be called by the `/init_main script`, if present (part of initramfs)
  - `/mnt-system/SYSTEM_amd64/init_main_hook.sh`
  - `/mnt-system/SYSTEM_i386/init_main_hook.sh`
    - possibly forwarding to `/mnt-system/SYSTEM/init_main_hook.sh`
- used to develop new/adapted `initramfs`

#### *hook:* init_hook.sh
- will be called from init_main script (part of initramfs) or
  from `init_main_hook.sh`, if present
  - `/mnt-system/SYSTEM_amd64/init_hook.sh`
  - `/mnt-system/SYSTEM_i386/init_hook.sh`
    - possibly forwarding to `/mnt-system/SYSTEM/init_hook.sh`
- used to to adapt the `matrixxx live system`

## busybox init (/sbin/init -> /bin/busybox init)
- loads busybox `/etc/inittab`

### /etc/init.d/system-autoconfig.sh (inittab)
- will be started by `/etc/inittab`
- starts system-hwsetup - caller of system-mkxorgconfig
  - `/sbin/system-hwsetup`: minimalistic hardware configuration tool
  - `/sbin/system-mkxorgconfig`: create a working Xorg configuration
    `/etc/X11/xorg.conf` file
- used to configure the hardware

#### *hook:* /mnt-system/SYSTEM/system_hook.sh
- will be called from `system-autoconfig.sh`
  - `/mnt-system/SYSTEM_amd64/system_hook.sh`
  - `/mnt-system/SYSTEM_i386/system_hook.sh`
    - possibly forwarding to `/mnt-system/SYSTEM/system_hook.sh`
  - used to start `/mnt-system/SYSTEM/storage_mount.sh`
  - used to start `/mnt-system/SYSTEM/autostart/autostart_root.sh`

### /etc/init.d/system-startx.sh
- will be started by `/etc/inittab`
  - starts the display manager (by default `nodm`) which starts `Xorg`
    (declared in `/etc/X11/xorg.conf`)

### /etc/X11/Xsession (used by startx resp. Xorg)
- starts among other things `/etc/X11/Xsession.d/45system` which starts
  `/mnt-system/SYSTEM/Xsession_hook.sh`

#### *hook:* /mnt-system/SYSTEM/Xsession_hook.sh
- remove startup desktop files from `/etc/xdg/autostart/` unless necessary
  - note: These files are created automatically during OS installation.
    However, the automatic start is not desired or necessary for `matrixxx`.

### /etc/xdg/autostart/PipeWire.desktop
- will be startet by `XDG Autostart`
- starts `/usr/bin/system-pipewire-starter` which starts
  `/mnt-system/SYSTEM/system-pipewire-starter_hook.sh`

#### *hook:* /mnt-system/SYSTEM/system-pipewire-starter_hook.sh
- used to start `/mnt-system/SYSTEM/autostart/autostart--audio.sh`


