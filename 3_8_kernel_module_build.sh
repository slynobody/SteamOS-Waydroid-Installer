#!/bin/bash
clear

sudo steamos-readonly disable
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --populate holo
#echo "<<<<<<<<<<<<<"
#echo "<<<< 'n' >>>>"
#echo "<<<<<<<<<<<<<"
#sudo pacman -Syu
echo "<<<<<<<<<<<<<"
echo "<<<< 'y' >>>>"
echo "<<<<<<<<<<<<<"
sudo pacman -S fakeroot dkms dnsmasq lxc debugedit

#get & install latest headers, 'main'-context
sudo wget https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/linux-neptune-611-headers-6.11.11.valve6-3-x86_64.pkg.tar.zst
sudo pacman -U ./linux-neptune-611-headers-6.11.11.valve6-3-x86_64.pkg.tar.zst

#get & install latest binder-dkms (which builds the missing kernel-module)
git clone https://aur.archlinux.org/binder_linux-dkms.git
cd binder_linux-dkms
makepkg
sudo pacman -U ./binder_linux-dkms-6.8-1-x86_64.pkg.tar.zst

cd ..
mkdir binder/6.11.11-valve6-3-neptune-611
#offer the kernel-module to the sd-waydroid-installer (one has always to adapt the script to include 3.8 latest)
sudo cp /usr/lib/modules/6.11.11-valve6-3-neptune-611-g8b3a15f817f8/updates/dkms/binder_linux.ko.zst binder/6.11.11-valve6-3-neptune-611


#remove now unnec packages (nec for future reinstalls!)
sudo  pacman -R fakeroot dkms binder_linux-dkms linux-neptune-68-headers
sudo steamos-readonly enable

#./steamos-waydroid-installer.sh
