#!/bin/bash

set -eux

HOSTNAME=chang
SSH_CONFIG=~/.ssh/config

if _match=$(grep -m 1 -n "^Host ${HOSTNAME}$" $SSH_CONFIG); then
  start=${_match%%:*}
  echo
  _match=$(tail -n +$((start + 1)) $SSH_CONFIG | grep -m 1 -n -v "^  ")
  length=${_match%%:*}

  sed -i".bak" "${start},$((start + length))d" $SSH_CONFIG
fi

echo "Host ${HOSTNAME}" >> $SSH_CONFIG
vagrant ssh-config | tail -n +2 >> $SSH_CONFIG
