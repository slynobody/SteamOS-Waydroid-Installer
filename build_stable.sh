#!/bin/bash
clear
/***
 *                     ___
 *        ___         /__/\         ___
 *       /  /\        \  \:\       /  /\
 *      /  /:/         \  \:\     /  /:/
 *     /__/::\     _____\__\:\   /  /:/
 *     \__\/\:\__ /__/::::::::\ /  /::\
 *        \  \:\/\\  \:\~~\~~\//__/:/\:\
 *         \__\::/ \  \:\  ~~~ \__\/  \:\
 *         /__/:/   \  \:\          \  \:\
 *         \__\/     \  \:\          \__\/
 *                    \__\/
 */
echo "lets build the binder-module for stable-channel"
sudo steamos-devmode enable --no-prompt
sudo -s pacman -S fakeroot dkms debugedit --noconfirm --overwrite "*"


#get & install latest headers, 'main'-context
sudo wget https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.7/os/x86_64/linux-neptune-611-headers-6.11.11.valve14-1-x86_64.pkg.tar.zst
sudo -s pacman -U ./linux-neptune-611-headers-6.11.11.valve14-1-x86_64.pkg.tar.zst --noconfirm --overwrite "*"

#get & install latest binder-dkms (which builds the missing kernel-module)
git clone https://aur.archlinux.org/binder_linux-dkms.git
cd binder_linux-dkms
sudo sed -i -e '/^OPTIONS=/s/debug/!debug/' /etc/makepkg.conf
makepkg
sudo -s pacman -U ./binder_linux-dkms-6.14-1-x86_64.pkg.tar.zst --noconfirm --overwrite "*"

cd ..
mkdir binder/6.11.11-valve14-1-neptune-611 &> /dev/null
#offer the kernel-module to the sd-waydroid-installer (or manually adapt to include 3.7 latest)
sudo cp /usr/lib/modules/6.11.11-valve14-1-neptune-611-g96885212a919/updates/dkms/binder_linux.ko.zst binder/6.11.11-valve14-1-neptune-611 &> /dev/null


#remove old packages (nec for updating with higher kernel version later on)
sudo pacman -R fakeroot dkms binder_linux-dkms linux-neptune-611-headers --noconfirm
#sudo steamos-readonly enable

./steamos-waydroid-installer.sh
