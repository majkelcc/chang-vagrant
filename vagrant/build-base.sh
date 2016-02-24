#!/bin/bash

set -eux

TARGET_BOX=base.box

export VAGRANT_VAGRANTFILE=Vagrantfile-base

vagrant destroy --force
vagrant box update
vagrant up
vagrant package
mv package.box $TARGET_BOX
vagrant destroy --force

cat <<<"package created successfully"
