#!/bin/bash

# TO BE CONFIGURED
##########
transmission_dir="/mnt/grosso"
##########

apt-get update 
apt-get install -y ntfs-3g screen transmission-daemon samba at  weechat  youtube-dl git
apt-get install -y build-essential libssl-dev libffi-dev python3-dev 
apt-get install -y python3-pip
pip3 install --upgrade pip3
pip3 install virtualenv 
mkdir /mnt/grosso

echo "alias bilancia='du -hs */ | sort -hr | head'" >> /home/pi/.bashrc

#add grosso
#nano /etc/fstab
echo "UUID=68809666-4130-4ba4-a5c1-8e1d68275d5d    /mnt/grosso    ext4    defaults,errors=remount-ro 0    1" >> /etc/fstab

#install hassio
apt-get install -y software-properties-common apparmor-utils apt-transport-https ca-certificates curl dbus jq network-manager
systemctl disable ModemManager
systemctl stop ModemManager
curl -fsSL get.docker.com | sh
curl -sL "https://raw.githubusercontent.com/Kanga-Who/home-assistant/master/supervised-installer.sh" | bash -s -- -m raspberrypi4

#configure transmission

service transmission-daemon stop
python3 replace_json.py $transmission_dir
service transmission-daemon restart

#reboot
