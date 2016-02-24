#!/bin/bash

set -eux

cp -r /projects ~/projects

for project in $(find ~/projects -mindepth 1 -maxdepth 1 -type d); do
  [ -f $project/.chang/bin/build ] && chang-run ${project##*/} build
done

rm -rf ~/projects
