#!/bin/bash
clear

sudo steamos-readonly disable
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --populate holo
sudo pacman -Syu
sudo pacman-key --populate holo
echo "<<<<<<<<<<<<<"
echo "<<<< 'y' >>>>"
echo "<<<<<<<<<<<<<"
sudo pacman -S fakeroot dkms

#get & install latest headers, 'main'-context (next supposedly would read *valve8*-something)
wget https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/linux-neptune-68-headers-6.8.12.valve2-1-x86_64.pkg.tar.zst
sudo pacman -U ./linux-neptune-68-headers-6.8.12.valve2-1-x86_64.pkg.tar.zst

#get & install latest binder-dkms (which builds the missing kernel-module)
git clone https://aur.archlinux.org/binder_linux-dkms.git
cd binder_linux-dkms
makepkg
sudo pacman -U ./binder_linux-dkms-6.8-1-x86_64.pkg.tar.zst

cd ..
mkdir binder/6.8.12-valve2-1-neptune-68
#offer the kernel-module to the sd-waydroid-installer (one has always to adapt the script to include 3.7 latest)
sudo cp /usr/lib/modules/6.8.12-valve2-1-neptune-68-g8d066aeacd49/updates/dkms/binder_linux.ko.zst binder/6.8.12-valve2-1-neptune-68

#remove now unnec packages (nec for future reinstalls!)
sudo  pacman -R fakeroot dkms binder_linux-dkms linux-neptune-68-headers
sudo steamos-readonly enable
