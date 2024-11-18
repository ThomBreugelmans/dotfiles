# Gentoo setup

## disks
- efi
- luks -> xfs
- swap (16G)

### packages
- sys-fs/dosfstools
- sys-fs/xfsprogs
- sys-fs/e2fsprogs

## LUKS
passphrase setup
``` shell
cryptsetup luksFormat --key-size 512 <device>
```
backing up the header file (if later gets corrupted)
``` shell
cryptsetup luksHeaderBackup <device> --header-backup-file <file>
```
> [!IMPORTANT]
> Do not forget to save backup file to somewhere save (e.g. cloud or other storage)
**Opening and formatting**

``` shell
cryptsetup luksOpen <device> <name>
mkfs.xfs -L rootfs /dev/mapper/<name>
```
mounting
``` shell
mkdir -p /mnt/gentoo
mount LABEL=rootfs /mnt/gentoo
```
### packages
- sys-fs/cryptsetup

## stage file
download appropriate stage file from https://www.gentoo.org/downloads
extract:
``` shell
tar xpvf <tarfile> --xattrs-include='*.*' --numeric-owner -C /mnt/gentoo
```

## configuring
we can download my basic setup from this repo and put the files in the proper directories (mainly `/etc/portage`)
Consists of setting compile flags `-march=native` and MAKEOPTS `-j10` ACCEPT_LICENSE `*` and some other system configurations
- VIDEO_CARDS
- USE="modules-sign ..."
- cpuid2cpuflags

## chrooting
setting up DNS
``` shell
cp --dereference /etc/resolv.conf /mnt/gentoo/etc
```
chrooting (if from gentoo)
``` shell
arch-chroot /mnt/gentoo
```
chrooting (not gentoo)
``` shell
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-rslave /mnt/gentoo/run
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
mount --types tmpfs --options nosud,nodev,noexec shm /dev/shm
chmod 1777 /dev/shm /run/shm

chroot /mnt/gentoo /bin/bash
source /etc/profile
```

**setting up for bootloader**
mount efi
``` shell
mount <device> /efi
```

## updating portage
``` shell
emerge-webrsync
emerge --sync
```

## timezone & locale setup
``` shell
ln -sf ../usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
SELECT=$(eselect locale list | grep "en_US.utf8" | awk -F" " "{print $1}" | tr -d "[]"); eselect locale set $SELECT
env-update && source /etc/profile
```

## install firmware/microcode
``` shell
emerge --ask sys-kernel/linux-firmware sys-firmware/sof-firmware
```

## set up fstab
...

## setup kernel
we will use a distribution kernel (for now), so set the `dist-kernel` USE flag if not set already.
``` shell
emerge --ask sys-kernel/gentoo-kernel
```
and set up kernel sources for this we already have a package.use file in the repo (with the `symlink` flag set)
``` shell
emerge --ask sys-kernel/gentoo-sources
```
using the kernel sources we can configure the gentoo-kernel if we require (for extra features or tweaking)
TODO

## initramfs
### systemd-boot bootloader
from the dotfiles you can get the `systemd-boot` package.use file, it should contain:
``` text
sys-apps/systemd-utils boot kernel-install
sys-kernel/installkernel systemd systemd-boot
```

install systemd-boot with `bootctl install` after having emerged the requiring package
#### packages
- sys-apps/systemd-utils


### dracut
you can get the `dracut` package.use file from the repo
``` text
sys-apps/systemd-utils boot kernel-install
sys-kernel/installkernel dracut uki
```
also put the `dracut.conf` in `/etc/dracut.conf`
``` text
uefi="yes"
kernel_cmdline="root=UUID=<rootfs-uuid>"
# these are for luks
add_dracutmodules+=" crypt dm rootfs-block "
kernel_cmdline+=" rd.luks.uuid=<luks-uuid> rd.luks.allow-discards "
```
#### packages
- sys-apps/systemd-utils
- sys-kernel/installkernel
- sys-fs/lvm2 (if using LUKS)

### secure boot
TODO

### rebuilding initramfs
after setting up all this, we should rebuild the initramfs
``` shell
emerge --config sys-kernel/gentoo-kernel
```

## SSD Trim
### with luks
add this line the to `kernel_cmdline` of dracut
``` text
kernel_cmdline+=" rd.luks.allow-discards "
```
and add this to the `/etc/lvm/lvm.conf`
``` text
issue_discards = 1
```

## Generic System setup
### hostname
### new user
``` shell
useradd -m -G wheel,users,video,audio,usb,cron <username>
```
### sudo
enable `wheel` group in `/etc/sudoers`
#### packages
- app-admin/sudo
### network
start dhcp client
``` shell
rc-update add dhcpcd default
rc-service dhcpcd start
```
enable netifrc

``` shell
emerge --ask --noreplace net-misc/netifrc
echo 'config_eth0="dhcp"' > /etc/conf.d/net
cd /etc/init.d
ln -s net.lo net.eth0
rc-update add net.eth0 default
```
update `/etc/hosts` file with hostname and localhost

``` shell
echo -e "127.0.0.1\t<hostname>.homenetwork <hostname> localhost" >> /etc/hosts
```

#### packages
- net-misc/dhcpcd
- net-misc/netifrc
### wireless
### audio
### bluetooth
### graphics
### zsh
#### packages
- app-shells/zsh
- app-shells/zsh-completions
- app-shells/gentoo-zsh-completions
### chrony
### io-scheduler-udev-rules
### security
#### disable root login
`passwd -dl root`
#### auditting
#### logging
#### cron? (cronie)


## cleaning installation
remove tar file
clean install artifacts of emerge/portage
``` shell
emerge --depclean
```

## after install
we should verify that internet is working as expected (it could be that we defined the wrong device name)
