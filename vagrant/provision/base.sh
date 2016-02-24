#!/bin/bash

set -eux

export DOCKER_COMPOSE_RELEASE=1.6.1

sudo apt-get update
sudo apt-get -y install \
  htop tmux vim

ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh-keyscan bitbucket.com >> ~/.ssh/known_hosts

sudo -s <<LOCALE
(echo LANG=en_US; echo LC_CTYPE=en_US.utf8) >> /etc/environment
ln -fs /usr/share/zoneinfo/UTC /etc/localtime
LOCALE

sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

sudo -s <<BIN
cp /vm_shared_folder/bin/unison /usr/local/bin/
cp /vm_shared_folder/bin/unison-fsmonitor /usr/local/bin/
cp /vm_shared_folder/bin/chang-run /usr/local/bin/
BIN

touch ~/.hushlogin

sudo -s <<DOCKER_ENGINE
apt-get -y install apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-cache policy docker-engine
apt-get -y install docker-engine
usermod -G docker vagrant
DOCKER_ENGINE

sudo -s <<DOCKER_COMPOSE
curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_RELEASE}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod a+xr /usr/local/bin/docker-compose
DOCKER_COMPOSE

sudo -s <<CLEANUP
apt-get -y autoremove
apt-get -y clean
CLEANUP
