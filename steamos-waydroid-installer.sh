#!/bin/bash

clear

echo SteamOS Waydroid Installer Script by ryanrudolf
echo https://github.com/ryanrudolfoba/SteamOS-Waydroid-Installer // adapted by sln
sleep 2

# define variables here
script_version_sha=$(git rev-parse --short HEAD)
steamos_version=$(cat /etc/os-release | grep -i version_id | cut -d "=" -f2)
kernel_version=$(uname -r | cut -d "-" -f 1-5 )
stable_kernel1=6.11.11-valve14-1-neptune-611
beta_kernel1=6.11.11-valve19-1-neptune-611
beta_kernel2=6.11.11-valve19-1-neptune-611
preview_kernel1=6.11.11-valve19-1-neptune-611
main_kernel1=6.11.11-valve20-1-neptune-611
WAYDROID_SCRIPT=https://github.com/casualsnek/waydroid_script.git
DIR_WAYDROID_SCRIPT=$(mktemp -d)/waydroid_script
FREE_HOME=$(df /home --output=avail | tail -n1)
FREE_VAR=$(df /var --output=avail | tail -n1)
PLUGIN_LOADER=/home/deck/homebrew/services/PluginLoader

# android TV builds
ANDROID11_TV_IMG=https://github.com/supechicken/waydroid-androidtv-build/releases/download/20241207/lineage-18.1-20241207-UNOFFICIAL-SupeChicken666-WaydroidATV.zip
ANDROID13_TV_IMG=https://github.com/supechicken/waydroid-androidtv-build/releases/download/20250327/lineage-20.0-20250327-UNOFFICIAL-WaydroidATV_x86_64.zip

# old android 13 builds as of May 03 2025
#ANDROID13_GAPPS_IMG=https://sourceforge.net/projects/waydroid/files/images/system/lineage/waydroid_x86_64/lineage-20-20250503-GAPPS-waydroid_x86_64-system.zip/download#

#ANDROID13_NOGAPPS_IMG=https://sourceforge.net/projects/waydroid/files/images/system/lineage/waydroid_x86_64/lineage-20-20250503-VANILLA-waydroid_x86_64-system.zip/download#

#ANDROID13_VENDOR_IMG=https://sourceforge.net/projects/waydroid/files/images/vendor/waydroid_x86_64/lineage-20-20250503-MAINLINE-waydroid_x86_64-vendor.zip/download#

# new android 13 builds as of May 31 2025
ANDROID13_GAPPS_IMG=https://sourceforge.net/projects/waydroid/files/images/system/lineage/waydroid_x86_64/lineage-20.0-20250531-GAPPS-waydroid_x86_64-system.zip/download#
ANDROID13_NOGAPPS_IMG=https://sourceforge.net/projects/waydroid/files/images/system/lineage/waydroid_x86_64/lineage-20.0-20250531-VANILLA-waydroid_x86_64-system.zip/download#
ANDROID13_VENDOR_IMG=https://sourceforge.net/projects/waydroid/files/images/vendor/waydroid_x86_64/lineage-20.0-20250531-MAINLINE-waydroid_x86_64-vendor.zip/download#

# android TV hash
ANDROID11_TV_IMG_HASH=680971aaeb9edc64d9d79de628bff0300c91e86134f8daea1bbc636a2476e2a7
ANDROID13_TV_IMG_HASH=2ac5d660c3e32b8298f5c12c93b1821bc7ccefbd7cfbf5fee862e169aa744f4c

# old android 13 hash for build date as of May 03 2025
#ANDROID13_GAPPS_IMG_HASH=3c6eb7235e2bb4c4568194a33147017b6ab2e136467e8c5864b30a3e3e09e39e

#ANDROID13_NOGAPPS_IMG_HASH=60e2bbb7b821132b4518c9fa22581845742e09edd858831465e91a8a6b9c4087

#ANDROID13_VENDOR_IMG_HASH=e5331c517553873620b547e02fd972df40cf060ddad37856fa15f22442ae87f3

# new android 13 hash for build date as of May 31 2025
ANDROID13_GAPPS_IMG_HASH=2f1b81436de172658f5008adae16ef429339d09348fd713e9f3029130ac72467

ANDROID13_NOGAPPS_IMG_HASH=e01fbdcaa17369c6373c52e40110e38a1e80bd481b1694bbe94c513683ee8070

ANDROID13_VENDOR_IMG_HASH=4e99d932ffb34ec4d69eda41ee484c19d43dcc7e35ac3ef4ec4a66cf7671f915

echo script version: $script_version_sha

# define functions here
source functions.sh

# run the sanity checks
source sanity-checks.sh

# sanity checks are all good. lets go!
# create AUR directory where casualsnek script will be saved
mkdir -p ~/AUR/waydroid &> /dev/null

# perform git clone but lets cleanup first in case the directory is not empty
echo Cloning casualsnek / aleasto waydroid_script repo.
echo This can take a few minutes depending on the speed of the internet connection and if github is having issues.
echo If the git clone is slow - cancel the script \(CTL-C\) and run it again.

git clone --depth=1 $WAYDROID_SCRIPT $DIR_WAYDROID_SCRIPT &> /dev/null

if [ $? -eq 0 ]
then
	echo casualsnek / aleasto waydroid_script repo has been successfully cloned!
else
	echo Error cloning casualsnek / aleasto waydroid_script repo!
	rm -rf $DIR_WAYDROID_SCRIPT
	cleanup_exit
fi

# unlock the readonly and initialize keyring using the devmode method
echo -e "$current_password\n" | sudo -S steamos-devmode enable --no-prompt > /dev/null

if [ $? -eq 0 ]
then
	echo pacman keyring has been initialized!
else
	echo Error initializing keyring!
	cleanup_exit
fi

# lets install and enable the binder module so we can start waydroid right away
binder_loaded=$(lsmod | grep -q binder; echo $?)
binder_differs=$(cmp -s binder/$kernel_version/binder_linux.ko.zst /lib/modules/$(uname -r)/binder_linux.ko.zst; echo $?)
if [ "$binder_loaded" -ne 0 ] || [ "$binder_differs" -ne 0 ]
then
	echo Binder kernel module not found or not up to date! Installing binder!
	echo -e "$current_password\n" | sudo -S cp binder/$kernel_version/binder_linux.ko.zst /lib/modules/$(uname -r) && \
	echo -e "$current_password\n" | sudo -S depmod -a && \
	echo -e "$current_password\n" | sudo -S modprobe binder-linux device=binder,hwbinder,vndbinder

	if [ $? -eq 0 ]
	then
		echo Binder kernel module has been installed!
	else
		echo Error installing binder kernel module. Run the script again to install waydroid.
		cleanup_exit
	fi
else
	echo Binder kernel module already loaded and up to date! No need to reinstall binder!
fi

# ok lets install precompiled waydroid
echo -e "$current_password\n" | sudo -S pacman -U --noconfirm waydroid/libgbinder-1.1.42-2-x86_64.pkg.tar.zst waydroid/libglibutil-1.0.80-1-x86_64.pkg.tar.zst waydroid/python-gbinder-1.1.2-3-x86_64.pkg.tar.zst waydroid/waydroid-1.5.1-1-any.pkg.tar.zst > /dev/null && \

# ok lets install additional packages from pacman repo
echo -e "$current_password\n" | sudo -S pacman -S --noconfirm wlroots cage wlr-randr > /dev/null

if [ $? -eq 0 ]
then
	echo waydroid and cage has been installed!
	echo -e "$current_password\n" | sudo -S systemctl disable waydroid-container.service
else
	echo Error installing waydroid and cage. Run the script again to install waydroid.
	cleanup_exit
fi

# firewall config for waydroid0 interface to forward packets for internet to work
echo -e "$current_password\n" | sudo -S firewall-cmd --zone=trusted --add-interface=waydroid0 &> /dev/null
echo -e "$current_password\n" | sudo -S firewall-cmd --zone=trusted --add-port=53/udp &> /dev/null
echo -e "$current_password\n" | sudo -S firewall-cmd --zone=trusted --add-port=67/udp &> /dev/null
echo -e "$current_password\n" | sudo -S firewall-cmd --zone=trusted --add-forward &> /dev/null
echo -e "$current_password\n" | sudo -S firewall-cmd --runtime-to-permanent &> /dev/null

# lets install the custom config files
mkdir ~/Android_Waydroid &> /dev/null

# waydroid binder configuration file
echo -e "$current_password\n" | sudo -S cp extras/waydroid_binder.conf /etc/modules-load.d/waydroid_binder.conf
echo -e "$current_password\n" | sudo -S cp extras/options-waydroid_binder.conf /etc/modprobe.d/waydroid_binder.conf

# waydroid startup and shutdown scripts
echo -e "$current_password\n" | sudo -S cp extras/waydroid-startup-scripts /usr/bin/waydroid-startup-scripts
echo -e "$current_password\n" | sudo -S cp extras/waydroid-shutdown-scripts /usr/bin/waydroid-shutdown-scripts
echo -e "$current_password\n" | sudo -S chmod +x /usr/bin/waydroid-startup-scripts /usr/bin/waydroid-shutdown-scripts

# custom sudoers file do not ask for sudo for the custom waydroid scripts
echo -e "$current_password\n" | sudo -S cp extras/zzzzzzzz-waydroid /etc/sudoers.d/zzzzzzzz-waydroid
echo -e "$current_password\n" | sudo -S chown root:root /etc/sudoers.d/zzzzzzzz-waydroid

# waydroid launcher, toolbox and updater
cp extras/Android_Waydroid_Cage.sh extras/Waydroid-Toolbox.sh extras/Waydroid-Updater.sh extras/Android_Waydroid_Cage-experimental.sh ~/Android_Waydroid
chmod +x ~/Android_Waydroid/*.sh

# desktop shortcuts for toolbox + updater
ln -s ~/Android_Waydroid/Waydroid-Toolbox.sh ~/Desktop/Waydroid-Toolbox &> /dev/null
ln -s ~/Android_Waydroid/Waydroid-Updater.sh ~/Desktop/Waydroid-Updater &> /dev/null

# lets check if this is a reinstall
grep redfin /var/lib/waydroid/waydroid_base.prop &> /dev/null || grep PH7M_EU_5596 /var/lib/waydroid/waydroid_base.prop &> /dev/null
if [ $? -eq 0 ]
then
	echo This seems to be a reinstall. Lets just make sure the symlinks are in place!
	if [ ! -d /etc/waydroid-extra ]
	then
		echo -e "$current_password\n" | sudo -S mkdir /etc/waydroid-extra
		echo -e "$current_password\n" | sudo -S ln -s ~/waydroid/custom /etc/waydroid-extra/images &> /dev/null
	fi

	# all done lets re-enable the readonly
	echo -e "$current_password\n" | sudo -S steamos-readonly enable
	echo Waydroid has been successfully installed!
else
	echo Downloading waydroid image from sourceforge.
	echo This can take a few seconds to a few minutes depending on the internet connection and the speed of the sourceforge mirror.
	echo Sometimes it connects to a slow sourceforge mirror and the downloads are slow -. This is beyond my control!
	echo If the downloads are slow due to a slow sourceforge mirror - cancel the script \(CTL-C\) and run it again.

	# lets initialize waydroid
	mkdir -p ~/waydroid/{images,custom,cache_http,host-permissions,lxc,overlay,overlay_rw,rootfs}
	echo -e "$current_password\n" | sudo mkdir /var/lib/waydroid &> /dev/null
	echo -e "$current_password\n" | sudo -S ln -s ~/waydroid/images /var/lib/waydroid/images &> /dev/null
	echo -e "$current_password\n" | sudo -S ln -s ~/waydroid/cache_http /var/lib/waydroid/cache_http &> /dev/null

	# place custom overlay files here - key layout, hosts, audio.rc etc etc
	# copy fixed key layout for Steam Controller
	echo -e "$current_password\n" | sudo -S mkdir -p /var/lib/waydroid/overlay/system/usr/keylayout
	echo -e "$current_password\n" | sudo -S cp extras/Vendor_28de_Product_11ff.kl /var/lib/waydroid/overlay/system/usr/keylayout/

	# copy custom audio.rc patch to lower the audio latency
	echo -e "$current_password\n" | sudo -S mkdir -p /var/lib/waydroid/overlay/system/etc/init
	echo -e "$current_password\n" | sudo -S cp extras/audio.rc /var/lib/waydroid/overlay/system/etc/init/

	# copy custom hosts file from StevenBlack to block ads (adware + malware + fakenews + gambling + pr0n)
	echo -e "$current_password\n" | sudo -S mkdir -p /var/lib/waydroid/overlay/system/etc
	echo -e "$current_password\n" | sudo -S cp extras/hosts /var/lib/waydroid/overlay/system/etc

	# copy nodataperm.sh - this is to fix the scoped storage issue in Android 11
	chmod +x extras/nodataperm.sh
	echo -e "$current_password\n" | sudo -S cp extras/nodataperm.sh /var/lib/waydroid/overlay/system/etc

	Choice=$(zenity --width 1040 --height 320 --list --radiolist --multiple \
		--title "SteamOS Waydroid Installer  - https://github.com/ryanrudolfoba/SteamOS-Waydroid-Installer"\
		--column "Select One" \
		--column "Option" \
		--column="Description - Read this carefully!"\
		TRUE A13_GAPPS "Download official Android 13 image with Google Play Store."\
		FALSE A11_GAPPS "Download official Android 11 image with Google Play Store."\
		FALSE A13_NO_GAPPS "Download official Android 13 image without Google Play Store."\
		FALSE A11_NO_GAPPS "Download official Android 11 image without Google Play Store."\
		FALSE TV13_NO_GAPPS "Download unofficial Android 13 TV image without Google Play Store - thanks SupeChicken666!" \
		FALSE TV11_NO_GAPPS "Download unofficial Android 11 TV image without Google Play Store - thanks SupeChicken666!" \
		FALSE EXIT "***** Exit this script *****")

		if [ $? -eq 1 ] || [ "$Choice" == "EXIT" ]
		then
			echo User pressed CANCEL / EXIT. Goodbye!
			cleanup_exit

		elif [ "$Choice" == "A11_GAPPS" ]
		then
			echo Initializing Waydroid.
			echo -e "$current_password\n" | sudo -S waydroid init -s GAPPS
			check_waydroid_init

		elif [ "$Choice" == "A11_NO_GAPPS" ]
		then
			echo Initializing Waydroid.
			echo -e "$current_password\n" | sudo -S waydroid init
			check_waydroid_init

		elif [ "$Choice" == "TV11_NO_GAPPS" ]
		then
			prepare_custom_image_location
			download_image $ANDROID11_TV_IMG $ANDROID11_TV_IMG_HASH ~/waydroid/custom/android11tv "Android 11 TV"

			echo Applying fix for Leanback Keyboard.
			echo -e "$current_password\n" | sudo -S cp extras/ATV-Generic.kl /var/lib/waydroid/overlay/system/usr/keylayout/Generic.kl

			echo Initializing Waydroid.
 			echo -e "$current_password\n" | sudo -S waydroid init
			check_waydroid_init

		elif [ "$Choice" == "TV13_NO_GAPPS" ]
		then
			prepare_custom_image_location
			download_image $ANDROID13_TV_IMG $ANDROID13_TV_IMG_HASH ~/waydroid/custom/android13tv "Android 13 TV"

			echo Applying fix for Leanback Keyboard.
			echo -e "$current_password\n" | sudo -S cp extras/ATV-Generic.kl /var/lib/waydroid/overlay/system/usr/keylayout/Generic.kl

			echo Initializing Waydroid.
 			echo -e "$current_password\n" | sudo -S waydroid init
			check_waydroid_init
			
		elif [ "$Choice" == "A13_NO_GAPPS" ]
		then
			prepare_custom_image_location
			download_image $ANDROID13_NOGAPPS_IMG $ANDROID13_NOGAPPS_IMG_HASH ~/waydroid/custom/a13_nogapps "Android 13 NOGAPPS System"
			download_image $ANDROID13_VENDOR_IMG $ANDROID13_VENDOR_IMG_HASH ~/waydroid/custom/a13_vendor "Android 13 Vendor"

			echo Initializing Waydroid.
 			echo -e "$current_password\n" | sudo -S waydroid init
			check_waydroid_init
			
		elif [ "$Choice" == "A13_GAPPS" ]
		then
			prepare_custom_image_location
			download_image $ANDROID13_GAPPS_IMG $ANDROID13_GAPPS_IMG_HASH ~/waydroid/custom/a13_gapps "Android 13 GAPPS system"
			download_image $ANDROID13_VENDOR_IMG $ANDROID13_VENDOR_IMG_HASH ~/waydroid/custom/a13_vendor "Android 13 vendor"

			echo Initializing Waydroid.
 			echo -e "$current_password\n" | sudo -S waydroid init
			check_waydroid_init
		fi
	
	# run casualsnek / aleasto waydroid_script
	echo Install libndk, widevine and fingerprint spoof.
	install_android_extras

	# change GPU rendering to use minigbm_gbm_mesa
	echo -e $PASSWORD\n | sudo -S sed -i "s/ro.hardware.gralloc=.*/ro.hardware.gralloc=minigbm_gbm_mesa/g" /var/lib/waydroid/waydroid_base.prop

	echo Adding shortcuts to Game Mode. Please wait.
	steamos-add-to-steam /home/deck/Android_Waydroid/Android_Waydroid_Cage.sh  &> /dev/null
	sleep 15
	echo Android_Waydroid_Cage.sh shortcut has been added to Game Mode.
	steamos-add-to-steam /usr/bin/steamos-nested-desktop  &> /dev/null
	sleep 15
	echo steamos-nested-desktop shortcut has been added to Game Mode.

	# all done lets re-enable the readonly
	echo -e "$current_password\n" | sudo -S steamos-readonly enable
	echo Waydroid has been successfully installed!
fi

# sanity check - re-enable decky loader service if it's installed.
if [ -f $PLUGIN_LOADER ]
then
	echo Re-enabling the Decky Loader plugin loader service.
	echo -e "$current_password\n" | sudo -S systemctl start plugin_loader.service
fi

if zenity --question --text="Do you Want to Return to Gaming Mode?"; then
	qdbus org.kde.Shutdown /Shutdown org.kde.Shutdown.logout
fi
