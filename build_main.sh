#!/bin/bash
sudo steamos-devmode enable --no-prompt
sudo pacman -S fakeroot dkms dnsmasq lxc debugedit --noconfirm --overwrite "*"

#get & install latest headers, 'main'-context
sudo wget https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/linux-neptune-611-headers-6.11.11.valve20-1-x86_64.pkg.tar.zst
sudo pacman -U ./linux-neptune-611-headers-6.11.11.valve20-1-x86_64.pkg.tar.zst  --noconfirm --overwrite "*"

#get & install latest binder-dkms (which builds the missing kernel-module)
git clone https://aur.archlinux.org/binder_linux-dkms.git
cd binder_linux-dkms
makepkg
sudo pacman -U ./binder_linux-dkms-6.14-1-x86_64.pkg.tar.zst --noconfirm --overwrite "*"

cd ..
mkdir binder/6.11.11-valve20-1-neptune-611 &> /dev/null
#offer the kernel-module to the sd-waydroid-installer (one has always to adapt the script to include 3.8 latest)
sudo cp /usr/lib/modules/6.11.11-valve20-1-neptune-611-gd35c3ed359a0/updates/dkms/binder_linux.ko.zst binder/6.11.11-valve20-1-neptune-611 &> /dev/null

#remove now unnec packages (nec for future reinstalls!)
sudo  pacman -R fakeroot dkms binder_linux-dkms linux-neptune-611-headers --noconfirm --overwrite "*"
#sudo steamos-readonly enable

./steamos-waydroid-installer.sh
