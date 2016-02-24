#!/bin/bash

set -eux

boxes=`ls -1 $CHANG_DIR/put_box_here | grep -c ".box$"`

case $boxes in
  0)
    echo "put your vagrant box in \`put_box_here\` directory" >&2
    exit 1
    ;;
  1)
    vagrant destroy --force
    vagrant box add $CHANG_DIR/put_box_here/*.box --force --name=chang
    ;;
  *)
    echo "thou shalt put only one box in \`put_box_here\` directory" >&2
    exit 1
    ;;
esac
