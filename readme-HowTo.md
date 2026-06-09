---
defaults: standard
toc: false
---
<!-- *********************************************************************** -->
# HowTo: Generate a bootable Flash Storage Device
- Prerequisites:
  - a running Linux system with a formatting and partitioning tool
  - the shell script used here requires the following programs:
    bash, blockdev, dd, df, e2label resp. fatlabel, lsblk, parted, sleep, uname
1. formatting and partitioning the flash memory device (e.g. with `GParted`)
    - create (at least) one partition of type `msdos`
    - create a file system of type VFAT or ext4
    - set the owner and the group of the device to `1000` (main user here `xxx`)
2. download from <https://github.com/matrixxx-dev/matrixxx-boot-device-content>
   repository the current Code
    - Green button [<> Code] Download ZIP
    - you get matrixxx-boot-device-content-main.zip
3. copy the contents of the "matrixxx-boot-device-content-main" directory
   (contained in the "matrixxx-boot-device-content-main.zip" file) to your
   prepared flash storage device
4. navigate to the /boot/scripts directory on your flash device and execute
   ./script-bootinstall.sh (respectively take a look at the content first)
    - the script is interactive and allows you to choose whether to execute the
      action or cancel it
    - the script overwrites the boot sector on the drive where it is executed
      and installs `Syslinux`
    - The script will tell you which drive it is located on. However, you must
      decide whether you want to perform the action on that drive or not
5. parts of the operating system which **have to be** added
    - the initramfs file
    - the kernel and the corresponding kernel layer image as well as the firmware
      - navigate to the `/boot/scripts/.linux-kernel_*` directory on the device
        and execute `./script.sh`
        (this 'activates' the corresponding kernel version)
    - the OS
    - the remaster base

| system part     | generated with                                          | package (latest)                                        | device location |
| :---            | :---                                                    | :---                                                    | :---            |
| initramfs file  | [github: matrixxx-initrd-build][matrixxx-initrd-build]  | [initramfs-package][latest matrixxx-initramfs-package]  | /boot/syslinux  |
| kernel layer    | [github: matrixxx-kernel-build][matrixxx-kernel-build]  | [kernel_package][latest matrixxx_kernel_package]        | /boot/syslinux  |
| firmware layer  |                                                         | [firmware_package][latest matrixxx_firmware_package]    | /boot/syslinux  |
| OS layer        | [github: matrixxx-os-build][matrixxx-os-build]          | [OS-package 32bit][latest OS-package 32bit]             | /SYSTEM_i386    |
|                 |                                                         | [OS-package 64bit][latest OS-package 64bit]             | /SYSTEM_amd64   |
| remaster layer  | [github: matrixxx-remaster][matrixxx-remaster]          | [remaster-package][latest remaster-package]             | /SYSTEM         |

********************************************************************************
> [!WARNING]
> **DISCLAIMER:** THIS IS EXPERIMENTAL SOFTWARE. USE AT YOUR OWN RISK. THE
> AUTHOR CAN NOT BE HELD LIABLE UNDER ANY CIRCUMSTANCES FOR DAMAGE TO HARDWARE
> OR SOFTWARE, LOST DATA, OR OTHER DIRECT OR INDIRECT DAMAGE RESULTING FROM THE
> USE OF THIS SOFTWARE.
> YOU ARE RESPONSIBLE FOR YOUR OWN COMPLIANCE WITH ALL APPLICABLE LAWS.


********************************************************************************
# Anleitung: Erstellen eines bootfähigen Flash-Speichermediums
- Voraussetzungen:
  - Ein funktionierendes Linux-System mit einem Formatierungs- und
    Partitionierungstool
  - Das hier verwendete Shell-Skript benötigt folgende Programme:
    bash, blockdev, dd, df, e2label bzw. fatlabel, lsblk, parted, sleep, uname
1. Formatieren und Partitionieren des Flash-Speichermediums
    - Erstellen Sie mindestens eine Partition und erzeugen Sie ein Dateisystem
      des Typs VFAT oder ext4
2. Laden Sie den aktuellen Quellcode aus dem Repository
   <https://github.com/matrixxx-dev/matrixxx-boot-device-content> herunter:
    - Klicken Sie auf den grünen Button [<> Code] und wählen Sie „Download ZIP“.
    - Sie erhalten die Datei „matrixxx-boot-device-content-main.zip“.
3. Kopieren Sie den Inhalt des Verzeichnisses „matrixxx-boot-device-content-main“
   (enthalten in der Datei „matrixxx-boot-device-content-main.zip“) auf Ihr
   vorbereitetes Flash-Speichermedium.
4. Navigieren Sie auf dem Flash-Speichermedium zum Verzeichnis /boot/scripts
   und starten Sie ./script-bootinstall.sh (bzw. lesen Sie den Inhalt vorher
   durch).
    - Das Skript ist interaktiv und fragt Sie, ob die Aktion ausgeführt oder
      abgebrochen werden soll.
    - Das Skript überschreibt den Bootsektor des Laufwerks, auf dem es
      ausgeführt wird, und installiert Syslinux.
    - Das Skript zeigt Ihnen an, auf welchem ​​Laufwerk es sich befindet.
      Sie müssen jedoch selbst entscheiden, ob die Aktion auf diesem Laufwerk
      ausgeführt werden soll.
5. Zu installierende Teile des Betriebssystems:
    - Die 'initramfs' Datei
    - Der Kernel und das zugehörige Kernel-Layer-Image sowie die Firmware
      - Navigieren Sie auf dem Gerät zum Verzeichnis
        `/boot/scripts/.linux-kernel_*` und führen Sie `./script.sh` aus
        (dadurch wird die entsprechende Kernelversion 'aktiviert')
    - Das eigentliche Betriebssystem
    - Die Remaster-Basis

| system part     | generated with                                          | package (latest)                                        | device location |
| :---            | :---                                                    | :---                                                    | :---            |
| initramfs file  | [github: matrixxx-initrd-build][matrixxx-initrd-build]  | [initramfs-package][latest matrixxx-initramfs-package]  | /boot/syslinux  |
| kernel layer    | [github: matrixxx-kernel-build][matrixxx-kernel-build]  | [kernel_package][latest matrixxx_kernel_package]        | /boot/syslinux  |
| firmware layer  |                                                         | [firmware_package][latest matrixxx_firmware_package]    | /boot/syslinux  |
| OS layer        | [github: matrixxx-os-build][matrixxx-os-build]          | [OS-package 32bit][latest OS-package 32bit]             | /SYSTEM_i386    |
|                 |                                                         | [OS-package 64bit][latest OS-package 64bit]             | /SYSTEM_amd64   |
| remaster layer  | [github: matrixxx-remaster][matrixxx-remaster]          | [remaster-package][latest remaster-package]             | /SYSTEM         |

********************************************************************************
> [!WARNING]
> **DISCLAIMER:** DIES IST EXPERIMENTELLE SOFTWARE. DIE BENUTZUNG ERFOLGT AUF
> EIGENE GEFAHR. DER AUTOR KANN UNTER KEINEN UMSTÄNDEN HAFTBAR GEMACHT
> WERDEN FÜR SCHÄDEN AN HARD- UND SOFTWARE, VERLORENE DATEN UND ANDERE DIREKT
> ODER INDIREKT DURCH DIE BENUTZUNG DER SOFTWARE ENTSTEHENDE SCHÄDEN.
> FÜR DIE EINHALTUNG GESETZLICHER VORSCHRIFTEN SIND SIE SELBST VERANTWORTLICH.

<!-- *********************************************************************** -->
[matrixxx-initrd-build]: https://github.com/matrixxx-dev/matrixxx-initrd-build
[latest matrixxx-initramfs-package]:
https://github.com/matrixxx-dev/matrixxx-initrd-build/releases/download/v1.0.0/matrixxx-initramfs-package-1.1.2_2026-05-01.tar.xz
[matrixxx-kernel-build]: https://github.com/matrixxx-dev/matrixxx-kernel-build
[latest matrixxx_kernel_package]:
https://github.com/matrixxx-dev/matrixxx-kernel-build/releases/download/v1.0.0/matrixxx_kernel_package_v7.0.11.tar.xz
[latest matrixxx_firmware_package]:
https://github.com/matrixxx-dev/matrixxx-kernel-build/releases/download/v1.0.0/matrixxx_firmware_package_forky-20260427.tar.xz
[matrixxx-os-build]: https://github.com/matrixxx-dev/matrixxx-os-build
[latest OS-package 32bit]:
https://github.com/matrixxx-dev/matrixxx-os-build/releases/download/v1.0.0/matrixxx_OS-package-01-lxde-standard-i386.tar.xz
[latest OS-package 64bit]:
https://github.com/matrixxx-dev/matrixxx-os-build/releases/download/v1.0.0/matrixxx_OS-package-01-lxde-standard-amd64.tar.xz
[matrixxx-remaster]: https://github.com/matrixxx-dev/matrixxx-remaster
[latest remaster-package]:
https://github.com/matrixxx-dev/matrixxx-remaster/releases/download/v1.0.0/matrixxx_remaster-package-01.tar.xz


