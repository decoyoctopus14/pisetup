#!/bin/bash

apt-get update; 
apt-get install -y ntfs-3g screen transmission-daemon samba at  weechat  youtube-dl 
apt-get install build-essential libssl-dev libffi-dev python3-dev 
apt-get install python3-pip
pip3 install --upgrade pip3
pip3 install virtualenv 
mkdir /mnt/grosso


#nano /etc/fstab
echo "UUID=68809666-4130-4ba4-a5c1-8e1d68275d5d    /mnt/grosso    ext4    defaults,errors=remount-ro 0    1" >> /etc/fstab
