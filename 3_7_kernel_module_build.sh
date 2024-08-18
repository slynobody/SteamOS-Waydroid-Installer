#!/bin/bash
clear

sudo steamos-readonly disable
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --populate holo
echo "// answer 'no' to updates (latest gamescope seems to have errors)"
sudo pacman -Syu
sudo pacman-key --populate holo
echo "// answer 'yes' to each install"
sudo pacman -S fakeroot dkms

#get & install latest headers, 'main'-context (next supposedly would read *valve8*-something)
wget https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/linux-neptune-65-headers-6.5.0.valve13-1-x86_64.pkg.tar.zst
sudo pacman -U ./linux-neptune-65-headers-6.5.0.valve13-1-x86_64.pkg.tar.zst

#get & install latest binder-dkms (which builds the missing kernel-module)
git clone https://aur.archlinux.org/binder_linux-dkms.git
cd binder_linux-dkms
makepkg
sudo pacman -U ./binder_linux-dkms-6.8-1-x86_64.pkg.tar.zst

cd ..
mkdir binder/6.5.0-valve13-1-neptune-65-gd5e176bdacb0
#offer the kernel-module to the sd-waydroid-installer (one has to adapt the script to include 3.7 latest: 65-gd5e176bdacb0)
sudo cp /usr/lib/modules/6.5.0-valve13-1-neptune-65-gd5e176bdacb0/updates/dkms/binder_linux.ko.zst binder/6.5.0-valve13-1-neptune-65-gd5e176bdacb0

#remove now unnec packages (nec for future reinstalls!)
sudo pacman -R fakeroot dkms binder_linux-dkms linux-neptune-65-headers
sudo steamos-readonly enable
