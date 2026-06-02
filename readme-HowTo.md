---
defaults: github-markdown
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
      - generated with [github: matrixxx-initrd-build][matrixxx-initrd-build]
      - unpack the content of [latest matrixxx-initramfs-package]
        to `/boot/syslinux` of the device
    - the kernel and the corresponding kernel layer image as well as the firmware
      - generated with [github: matrixxx-kernel-build][matrixxx-kernel-build]
      - unpack the content of [latest matrixxx_kernel_package] and
        [latest matrixxx_firmware_package] to `/boot/syslinux` of the device
        (note: both are hidden folders)
      - navigate to the `/boot/scripts/.linux-kernel_*` directory on the device
        and execute `./script.sh`
        (this 'activates' the corresponding kernel version)
    - the OS
      - generated with [github: matrixxx-os-build][matrixxx-os-build])
      - unpack the content of [latest OS-package 32bit]
        to `/SYSTEM_i386` of the device
      - unpack the content of [latest OS-package 64bit]
        to `/SYSTEM_amd64` of the device
    - the Remaster base
      - generated with [github: matrixxx-remaster][matrixxx-remaster])
      - unpack the content of [latest remaster-package]
        to `/SYSTEM` of the device

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
5. parts of the operating system which **have to be** added
    - the initramfs file
      - generated with [github: matrixxx-initrd-build][matrixxx-initrd-build]
      - unpack the content of [latest matrixxx-initramfs-package]
        to `/boot/syslinux` of the device
    - the kernel and the corresponding kernel layer image as well as the firmware
      - generated with [github: matrixxx-kernel-build][matrixxx-kernel-build]
      - unpack the content of [latest matrixxx_kernel_package] and
        [latest matrixxx_firmware_package] to `/boot/syslinux` of the device
        (note: both are hidden folders)
      - navigate to the `/boot/scripts/.linux-kernel_*` directory on the device
        and execute `./script.sh`
        (this 'activates' the corresponding kernel version)
    - the OS
      - generated with [github: matrixxx-os-build][matrixxx-os-build]
      - unpack the content of [latest OS-package 32bit]
        to `/SYSTEM_i386` of the device
      - unpack the content of [latest OS-package 64bit]
        to `/SYSTEM_amd64` of the device
    - the Remaster base
      - generated with [github: matrixxx-remaster][matrixxx-remaster]
      - unpack the content of [latest remaster-package]
        to `/SYSTEM` of the device

5. Zu installierende Teile des Betriebssystems:
    - Die 'initramfs' Datei
      - generiert mit [github: matrixxx-initrd-build][matrixxx-initrd-build]
      - Entpacken Sie den Inhalt von [latest matrixxx-initramfs-package]
        nach `/boot/syslinux` des Geräts
    - Der Kernel und das zugehörige Kernel-Layer-Image sowie die Firmware
      - generiert mit [github: matrixxx-kernel-build][matrixxx-kernel-build]
      - Entpacken Sie den Inhalt von [latest matrixxx_kernel_package] und von
        [latest matrixxx_firmware_package] nach `/boot/syslinux` des Geräts
        (Hinweis: beide Inhalte sind versteckte Ordner).
      - Navigieren Sie auf dem Gerät zum Verzeichnis
        `/boot/scripts/.linux-kernel_*` und führen Sie `./script.sh` aus
        (dadurch wird die entsprechende Kernelversion 'aktiviert')
    - Das eigentliche Betriebssystem
      - generiert mit [github: matrixxx-os-build][matrixxx-os-build]
      - Entpacken Sie den Inhalt von [latest OS-package 32bit] nach
        `/SYSTEM_i386` des Geräts.
      - Entpacken Sie den Inhalt von [latest OS-package 64bit] nach
        `/SYSTEM_amd64` des Geräts
    - Die Remaster-Basis
      - generiert mit [github: matrixxx-remaster][matrixxx-remaster]
      - Entpacken Sie den Inhalt von [latest remaster-package] nach `/SYSTEM`
        des Geräts

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
https://github.com/matrixxx-dev/matrixxx-kernel-build/releases/download/v1.0.0/matrixxx_kernel_package_v7.0.9.tar.xz
[latest matrixxx_firmware_package]:
https://github.com/matrixxx-dev/matrixxx-kernel-build/releases/download/v1.0.0/matrixxx_firmware_package_forky-20260427.tar.xz
[matrixxx-os-build]: https://github.com/matrixxx-dev/matrixxx-os-build
[latest OS-package 32bit]:
https://github.com/matrixxx-dev/matrixxx-kernel-build/releases/download/
[latest OS-package 64bit]:
https://github.com/matrixxx-dev/matrixxx-kernel-build/releases/download/
[matrixxx-remaster]: https://github.com/matrixxx-dev/matrixxx-remaster
[latest remaster-package]:
https://github.com/matrixxx-dev/matrixxx-remaster/releases/download/
















