---
defaults: github-markdown
toc: false
---
<!-- *********************************************************************** -->
# HowTo: Generate a bootable Flash Storage Device
- Prerequisites:
  - A running Linux system with a formatting and partitioning tool
  - The shell script used here requires the following programs:
    bash, blockdev, dd, df, e2label resp. fatlabel, lsblk, parted, sleep, uname
1. format and partition the flash storage device
    - create (at least) one partition and create a file system
      of type VFAT or ext4
2. download from <https://github.com/matrixxx-dev/matrixxx-boot-device-content>
   repository the current Code
    - Green button [<> Code] Download ZIP
    - you get matrixxx-boot-device-content-main.zip
3. copy the contents of the "matrixxx-boot-device-content-main" directory
   (contained in the "matrixxx-boot-device-content-main.zip" file) to your
   prepared flash storage device.
4. Navigate to the /boot/scripts directory on your flash device and start
   ./script-bootinstall.sh (respectively take a look at the content first)
    - the script is interactive and allows you to choose whether to execute the
      action or cancel it.
    - the script overwrites the boot sector on the drive where it is executed
      and installs Syslinux.
    - The script will tell you which drive it is located on. However, you must
      decide whether you want to perform the action on that drive or not.

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

> [!WARNING]
> **DISCLAIMER:** DIES IST EXPERIMENTELLE SOFTWARE. DIE BENUTZUNG ERFOLGT AUF
> EIGENE GEFAHR. DER AUTOR KANN UNTER KEINEN UMSTÄNDEN HAFTBAR GEMACHT
> WERDEN FÜR SCHÄDEN AN HARD- UND SOFTWARE, VERLORENE DATEN UND ANDERE DIREKT
> ODER INDIREKT DURCH DIE BENUTZUNG DER SOFTWARE ENTSTEHENDE SCHÄDEN.
> FÜR DIE EINHALTUNG GESETZLICHER VORSCHRIFTEN SIND SIE SELBST VERANTWORTLICH.

















