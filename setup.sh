#!/bin/bash

# TO BE CONFIGURED
##########
transmission_dir="/mnt/grosso"
##########

apt-get update 
apt-get install -y ntfs-3g screen transmission-daemon samba at  weechat python3 git
apt-get install -y build-essential libssl-dev libffi-dev python3-dev 
apt-get install -y python3-pip
pip3 install --upgrade pip3
pip3 install virtualenv 
mkdir ${transmission_dir}

echo "alias bilancia='du -hs */ | sort -hr | head'" >> /home/pi/.bashrc

#add grosso
#nano /etc/fstab
#echo "UUID=68809666-4130-4ba4-a5c1-8e1d68275d5d    /mnt/grosso    ext4    defaults,errors=remount-ro 0    1" >> /etc/fstab

#configure transmission

service transmission-daemon stop
python3 replace_json.py $transmission_dir
service transmission-daemon restart


# install docker
apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "{ \
  \"exec-opts\": [\"native.cgroupdriver=systemd\"], \
  \"insecure-registries\": [\"registry.cube.local:5000\"],\
  \"experimental\": true,\
  \"log-driver\": "json-file",\
  \"storage-driver\": \"overlay2\",\
  \"log-opts\": {\
    \"max-size\": \"100m\"\
  }\
}\
" > /etc/docker/daemon.json


#install hassio
apt-get install -y software-properties-common apparmor-utils apt-transport-https ca-certificates curl dbus jq network-manager docker
systemctl disable ModemManager
systemctl stop ModemManager
#curl -fsSL get.docker.com | sh
curl -sL "https://raw.githubusercontent.com/Kanga-Who/home-assistant/master/supervised-installer.sh" | bash -s -- -m raspberrypi4


#reboot
