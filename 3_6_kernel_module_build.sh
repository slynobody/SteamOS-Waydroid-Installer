#!/bin/bash
clear

sudo steamos-devmode enable --no-prompt
sudo pacman -S fakeroot dkms
#get & install latest headers, 'main'-context (next supposedly would read *valve24-1*-something)
sudo wget https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.6/os/x86_64/linux-neptune-65-headers-6.5.0.valve24-1-x86_64.pkg.tar.zst
sudo pacman -U ./linux-neptune-65-headers-6.5.0.valve24-1-x86_64.pkg.tar.zst

#get & install latest binder-dkms (which builds the missing kernel-module)
git clone https://aur.archlinux.org/binder_linux-dkms.git
cd binder_linux-dkms
makepkg -f
sudo pacman -U ./binder_linux-dkms-6.14-1-x86_64.pkg.tar.zst

cd ..
#offer the kernel-module to the sd-waydroid-installer (adapt the script to include your kernel -> <uname>)
mkdir binder/6.5.0-valve24-1-neptune-65
sudo cp /usr/lib/modules/$(uname -r)/updates/dkms/binder_linux.ko.zst binder/6.5.0-valve24-1-neptune-65

#remove old packages (nec for updating with higher kernel version later on)
sudo pacman -R fakeroot dkms binder_linux-dkms linux-neptune-65-headers
sudo steamos-readonly enable
