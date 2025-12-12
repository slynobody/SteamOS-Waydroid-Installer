# Android-TV for SteamOS 3.9
## waydroid with android-TV for main-/dev-channel of steamos

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

2. install waydroid
> ./steamos-waydroid-installer.sh

3. Use privacy-friendly appstore to install your apps (also consider installing fstore)
> wget https://web.archive.org/web/20230928212250/https://f-droid.org/repo/com.aurora.store_47.apk
> waydroid app install ./com.aurora.store_47.apk

enjoy.

# FAQ

## read the above.
read it.

## i have problems downloading images / want a more current version of the android-images.
atv13 latest is included. (supechicken)

## how do i get SteamOS 3.9?
> Enter 'developer mode' (https://tuxexplorer.com/how-to-enable-developer-mode-on-steam-deck)
> 
> in developer-tab left enable 'extended update-channels'
> 
> in system-tab enable OS-Update-Channel 'Main'

## Rotation is not supported!
there is an experimental feature (https://youtube.com/watch?v=OxApPDhZn9I), but it does not do the rotation automatically (yet).

## What appstore should i use?
privacy-friedly <a href="https://web.archive.org/web/20230928212250/https://f-droid.org/repo/com.aurora.store_47.apk">'Aurora Store'</a> (and/or 'F-Droid' (https://f-droid.org/F-Droid.apk))

# Background
build on top of https://github.com/ryanrudolfoba/SteamOS-Waydroid-Installer

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
