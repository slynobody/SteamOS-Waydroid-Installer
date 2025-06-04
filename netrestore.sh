#!/bin/bash
sudo -S steamos-readonly disable
sudo -S firewall-cmd --zone=trusted --add-interface=waydroid0 
sudo -S firewall-cmd --zone=trusted --add-port=53/udp 
sudo -S firewall-cmd --zone=trusted --add-port=67/udp 
sudo -S firewall-cmd --zone=trusted --add-forward 
sudo -S firewall-cmd --runtime-to-permanent 
sudo -S steamos-readonly disable
