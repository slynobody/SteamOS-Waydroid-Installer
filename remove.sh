sudo -S steamos-readonly disable
echo --> your user-data resides in --> /home/deck/.local/share/waydroid/data -->  backup it up!
sudo -S pacman -R --noconfirm libglibutil libgbinder python-gbinder waydroid wlroots dnsmasq lxc
sudo -S rm -rf ~/waydroid /var/lib/waydroid ~/AUR
sudo -S rm /etc/sudoers.d/zzzzzzzz-waydroid /etc/modules-load.d/waydroid.conf /usr/bin/waydroid*
sudo -S rm /usr/bin/cage /usr/bin/wlr-randr &> /dev/null
sudo -S rm -rf ~/Android_Waydroid
sudo -S steamos-readonly enable
