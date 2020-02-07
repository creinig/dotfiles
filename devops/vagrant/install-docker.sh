#!/bin/bash

# docker
apt-get -y remove docker docker-engine docker.io containerd runc
apt-get update
apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker vagrant

systemctl enable docker
systemctl start docker


# podman
apt-get update -qq
apt-get install -qq -y software-properties-common uidmap
add-apt-repository -y ppa:projectatomic/ppa
apt-get update -qq
apt-get -qq -y install podman
apt-get -qq -y install skopeo
