# Android for SteamOS 3.7 / 3.8
## waydroid for stable, beta, main-channel, incl. auto-compiling of binder-module (for current kernel)

1. basics: copy/paste > konsole
> sudo steamos-devmode enable --no-prompt
> 
> sudo pacman -S git
> 
> git clone https://github.com/slynobody/SteamOS-Waydroid-Installer
> 
> cd SteamOS-Waydroid-Installer
>
> chmod +x *.sh

2. build binder module according to your channel (binder module will be compiled locally) & start waydroid-installation / update
> ./build_stable.sh
> 
 or
 > ./build_beta.sh
>
 or
> ./build_main.sh

3. Use privacy-friendly appstore to install your apps (also consider installing fstore)
> wget https://web.archive.org/web/20230928212250/https://f-droid.org/repo/com.aurora.store_47.apk
> waydroid app install ./com.aurora.store_47.apk

enjoy.

# FAQ

## read the faqs.
simply read it. and if you have problems, try to also think for yourself. incl. what errors you might have done.

## i have problems downloading images / want a more current version of the android-images.
android-tv13 latest is included (https://github.com/supechicken/waydroid-androidtv-build)

## how do i do a complete uninstall of waydroid (without wiping my data)? f.e. for a clean reinstall? 
> ./uninstall.sh

## things got updated on github, how do i update locally?
> git pull

or

> extras/Waydroid-Updater.sh

## how do i get SteamOS 3.8?
> Enter 'developer mode' (https://tuxexplorer.com/how-to-enable-developer-mode-on-steam-deck)
> 
> in developer-tab left enable 'extended update-channels'
> 
> in system-tab enable OS-Update-Channel 'Main'

## Rotation is not supported!
there is an experimental feature (https://youtube.com/watch?v=OxApPDhZn9I), but it does not do the rotation automatically (yet).

## What appstore should i use?
privacy-friedly <a href="https://web.archive.org/web/20230928212250/https://f-droid.org/repo/com.aurora.store_47.apk">'Aurora Store'</a> (and/or 'F-Droid' (https://f-droid.org/F-Droid.apk))

## This script has to be altered / redone when a new SteamOS-version ships.
will hopefully be updated when new kernels arrive (3.8, adapt it to your needs for compling 3.6-modules). 

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

<a href="https://artsandculture.google.com/experiment/viola-the-bird/nAEJVwNkp-FnrQ?cp=e30."><img src="https://images.pling.com/img/00/00/78/78/79/2160403/proxy-image1.jpeg"/></a>
