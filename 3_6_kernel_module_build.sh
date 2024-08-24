#!/bin/bash
clear

sudo steamos-readonly disable
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --populate holo
sudo yes '' | pacman -Syu
sudo yes '' | pacman -S fakeroot dkms
#get & install latest headers, 'main'-context (next supposedly would read *valve13*-something)

wget https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.6/os/x86_64/linux-neptune-65-headers-6.5.0.valve16-2-x86_64.pkg.tar.zst
sudo yes '' | pacman -U ./linux-neptune-65-headers-6.5.0.valve16-2-x86_64.pkg.tar.zst

#get & install latest binder-dkms (which builds the missing kernel-module)
git clone https://aur.archlinux.org/binder_linux-dkms.git
cd binder_linux-dkms
makepkg -f
sudo yes '' | pacman -U ./binder_linux-dkms-6.8-1-x86_64.pkg.tar.zst

cd ..
#offer the kernel-module to the sd-waydroid-installer (one has to adapt the script to include latest 3.6: g1889664e19fc )
mkdir binder/6.5.0-valve16-2-neptune-65-gc9ad4106624e
sudo cp /usr/lib/modules/6.5.0-valve16-2-neptune-65-gc9ad4106624e/updates/dkms/binder_linux.ko.zst binder/6.5.0-valve16-2-neptune-65-gc9ad4106624e

#remove old packages (nec for updating with higher kernel version later on)
sudo yes '' | pacman -R fakeroot dkms binder_linux-dkms linux-neptune-65-headers
sudo steamos-readonly enable
