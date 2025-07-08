Informations:

  Die folgenden Syslinux Labels können
    - über die Menue Liste ausgewählt werden
    - über das "boot:" Prompt eingegeben werden
      -> Während der Anzeige des Hauptmenues [ESC] drücken
      -> wird am Boot Prompt direkt [RETURN] gedrückt zürück zum Hauptmenue

    x32, x64        (Optionen [F2]) Start mit 32bit bzw. 64bit Kernel
    debug, debug64  (Optionen [F2]) Debug-Modus
    vesa
    fb640x480                       Framebuffer (z.B. Notebooks) 64bit Kernel
    fb800x600
    fb1024x768
    fb1280x1024
    fb1600x1200
    dos                             FreeDOS (Floppy-Emulation) starten
    grub                            Grub4DOS Bootmanager starten
    memtest                         Speichertest starten
    failsafe                        32bit Kernel vga=normal atapicd
                                    nosound noapic nolapic noacpi
                                    pnpbios=off acpi=off nofstab noscsi
                                    nodma noapm nousb nopcmcia nofirewire
                                    noagp nomce


