#!/bin/bash

set -eux

TARGET_BOX=cache.box

export VAGRANT_VAGRANTFILE=Vagrantfile-cache

vagrant destroy --force
vagrant up
vagrant package
mv package.box $TARGET_BOX
vagrant destroy --force

cat <<<"package created successfully"
