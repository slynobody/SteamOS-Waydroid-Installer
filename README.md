# Android on SteamOS 3.7 ('waydroid')
## -> updated, latest components, adapted to latest OS-changes (python 3.12., availability of packages, plasma 6.22)

> sudo steamos-readonly disable
> 
> sudo pacman-key --init
> 
> sudo pacman-key --populate archlinux
> 
> sudo pacman-key --populate holo
> 
> sudo pacman -S git
> 
> git clone https://github.com/slynobody/SteamOS-Waydroid-Installer
> 
> cd SteamOS-Waydroid-Installer
>
> chmod +x *.sh

1. Install Basics (alway answer 'yes', installs binder kernel-module, latest lxc + dnsmasq)
> ./3_7_kernel_module_build.sh

2. install latest base (use privacy-friendly 'Vanilla' / NoGApps)
> ./steamos-waydroid-installer.sh

3. Use privacy-friendly appstore
> wget https://web.archive.org/web/20230928212250/https://f-droid.org/repo/com.aurora.store_47.apk
> waydroid app install ./com.aurora.store_47.apk

enjoy.

# FAQ
## how do i update the steam deck to SteamOS 3.7?
> https://www.youtube.com/watch?v=vly4v6refcY

## Rotation is not supported!
there is an experimental feature (https://youtube.com/watch?v=OxApPDhZn9I), but it does not do the rotation automatically (yet).

## What appstore should i use?
privacy-friedly <a href="https://web.archive.org/web/20230928212250/https://f-droid.org/repo/com.aurora.store_47.apk">'Aurora Store'</a> (and/or 'F-Droid' (https://f-droid.org/F-Droid.apk))

## This script has to be altered / redone when a new SteamOS 3.7-version ships.
it will be updated if new kernels arrive. 

## error: no net after installation?!?
> ./netrestore.sh

# Background
scripts build on top of https://github.com/ryanrudolfoba/SteamOS-Waydroid-Installer
(letting dkms compile the binder-module for this kernel on your machine / not predelivering pre-fabricated kernel-modules out of security-reasons)

----
# about: waydroid 
A collection of tools that is packaged into an easy to use script that is streamlined and tested to work with the Steam Deck running on SteamOS: https://github.com/waydroid/waydroid

* The main program that does all the heavy lifting is [Waydroid - a container-based approach to boot a full Android system on a regular GNU/Linux system.](
* Waydroid Toolbox to easily toggle some configuration settings for Waydroid.
* [waydroid_script](https://github.com/casualsnek/waydroid_script) to easily add the libndk ARM translation layer and widevine.
* [libndk-fixer](https://github.com/Slappy826/libndk-fixer) is a fixed / improved libndk translation layer specific for Roblox [(demo guide here)](https://youtu.be/-czisFuKoTM?si=8EPXyzasi3no70Tl).

# Disclaimer
1. Do this at your own risk!
2. This is for educational and research purposes only!

# Mini-guides for Steam Deck Android Waydroid
This mini guides are tailor-fitted for the Steam Deck that uses the script provided in this repo. \
[How to Sideload APKs](https://youtu.be/LglEbSdRc0M) \
[How to Upgrade the Android Image](https://youtu.be/lfwoZZxXh7I) \
[How to Configure Fake Wi-Fi](https://youtu.be/LtMGmSSB52g) \
[How to Configure Fake Touchscreen / Configure Mouse Clicks as Touchscreen Input](https://youtu.be/Xt2ceq8ZUJ8) \
[How to Launch APKs Directly in Game Mode](https://youtu.be/pkRtPHfa_EM?si=broimKF1menbRxGg) \
[Configure for 1080p When in Docked Mode](https://youtu.be/D9ODCpjDK30) \
[Configure sdcard as Main Storage for Waydroid](https://youtu.be/Q4QzzjkfZeI) \
[Activate and Configure Mantis Gamepad Pro](https://youtu.be/icVOh7IIfE0) \
[How to Configure Roblox](https://youtu.be/-czisFuKoTM?si=8EPXyzasi3no70Tl) \
[How to Access the OBB Folder / How to Root](https://youtu.be/RurH-XTTSDQ)

<a href="https://artsandculture.google.com/experiment/viola-the-bird/nAEJVwNkp-FnrQ?cp=e30."><img src="https://images.pling.com/img/00/00/78/78/79/2160403/proxy-image1.jpeg"/></a>
