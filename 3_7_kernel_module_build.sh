#!/bin/bash
sudo steamos-devmode enable --no-prompt
sudo pacman -S fakeroot dkms dnsmasq lxc debugedit

#get & install latest headers, 'main'-context
sudo wget https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.7/os/x86_64/linux-neptune-611-headers-6.11.11.valve17-1-x86_64.pkg.tar.zst
sudo pacman -U ./linux-neptune-611-headers-6.11.11.valve17-1-x86_64.pkg.tar.zst

#get & install latest binder-dkms (which builds the missing kernel-module)
git clone https://aur.archlinux.org/binder_linux-dkms.git
cd binder_linux-dkms
makepkg
sudo pacman -U ./binder_linux-dkms-6.14-1-x86_64.pkg.tar.zst

cd ..
mkdir binder/6.11.11-valve17-1-neptune-611
#offer the kernel-module to the sd-waydroid-installer (or manually adapt to include 3.7 latest)
sudo cp /usr/lib/modules/6.11.11-valve17-1-neptune-611-g027868a0ac03/updates/dkms/binder_linux.ko.zst binder/6.11.11-valve17-1-neptune-611


#remove now unnec packages (nec for future reinstalls!)
sudo  pacman -R fakeroot dkms binder_linux-dkms linux-neptune-611-headers
sudo steamos-readonly enable

#./steamos-waydroid-installer.sh
