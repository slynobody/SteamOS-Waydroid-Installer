#!/bin/bash
echo This will clone the latest version of the script
sleep 2
cd ~/
rm -rf ~/steamos-waydroid-installer
git clone --depth=1 https://github.com/slynobody/SteamOS-Waydroid-Installer
cd ~/steamos-waydroid-installer
chmod +x steamos-waydroid-installer.sh
./steamos-waydroid-installer.sh
