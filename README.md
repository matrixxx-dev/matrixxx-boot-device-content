---
defaults: github-markdown
toc: false
---
<!-- *********************************************************************** -->
# matrixxx-boot-device-content
- This repository contains a composition of files that are necessary for
  the generation of a boot device for matrixxx (a D.I.Y linux live system)
- With the help of a script contained therein, a USB stick (or similar) can be
  made into a bootable medium
  (see [HowTo: Generate a bootable Flash Storage Device][readme: HowTo]
  ('en' and 'de')
- The parts of the operating system **have to be** added
  - the initramfs file
    - generated with [github: matrixxx-initrd-build][matrixxx-initrd-build]
  - the kernel and the corresponding kernel layer image as well as the firmware
    - generated with [github: matrixxx-kernel-build][matrixxx-kernel-build]
  - the OS
    - generated with [github: matrixxx-os-build][matrixxx-os-build]
  - the remaster base
    - generated with [github: matrixxx-remaster][matrixxx-remaster]

#### briefly:
- see [readme: about][]
- see [readme: HowTo][]
- see [readme: configuration scripts][]

#### links:
- home page of [Syslinux Project][]

<!-- *********************************************************************** -->
[readme: about]: SYSTEM/doc/readme-matrixxx.md
[readme: HowTo]: readme-HowTo.md
[readme: configuration scripts]:
SYSTEM/doc/readme-matrixxx-configuration-structure.md

[matrixxx-initrd-build]: https://github.com/matrixxx-dev/matrixxx-initrd-build
[matrixxx-kernel-build]: https://github.com/matrixxx-dev/matrixxx-kernel-build
[matrixxx-os-build]: https://github.com/matrixxx-dev/matrixxx-os-build
[matrixxx-remaster]: https://github.com/matrixxx-dev/matrixxx-remaster

[Syslinux Project]: https://wiki.syslinux.org

********************************************************************************
> [!WARNING]
> **DISCLAIMER:** THIS IS EXPERIMENTAL SOFTWARE. USE AT YOUR OWN RISK. THE
> AUTHOR CAN NOT BE HELD LIABLE UNDER ANY CIRCUMSTANCES FOR DAMAGE TO HARDWARE
> OR SOFTWARE, LOST DATA, OR OTHER DIRECT OR INDIRECT DAMAGE RESULTING FROM THE
> USE OF THIS SOFTWARE.
> YOU ARE RESPONSIBLE FOR YOUR OWN COMPLIANCE WITH ALL APPLICABLE LAWS.

********************************************************************************
> [!NOTE]
> All markdown files contain a `pandoc` specific extension:
> **yaml_metadata_block**. This block is displayed as a table by GitHub,
> but is useful (for me) for checking the appearance.

> [!NOTE]
> Regarding external links:
> This description may contain links to external websites operated by third
> parties, over which I have no control. Therefore, I cannot be held responsible
> for the content of these external websites. The sole responsibility for the
> content of these linked pages lies with the respective provider or operator.

********************************************************************************
