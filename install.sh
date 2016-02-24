#!/usr/bin/env bash

set -eux

source ./rcscripts/install.sh

bash -eux <<VAGRANT
  cd vagrant
  ./add-box.sh
  vagrant up
  . vagrant2sshconfig.sh
VAGRANT

chang sync --init

cat <<DONE
      ____
     /.   \\__
    /_  \_/  \\
   // \\  ___ |\\
       |_| |_|

chang installed!
DONE