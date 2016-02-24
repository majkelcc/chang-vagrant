#!/bin/bash

export CHANG_DIR=
export CHANG_PROJECTS_DIR=$CHANG_DIR/projects

sed "s/export CHANG_DIR=XXX/export CHANG_DIR=${PWD//\//\\\/}/" rcscripts/changrc > ~/.changrc
source ~/.changrc

if ! grep -c "source ~/.changrc" ~/.bash_profile >/dev/null; then
  echo "source ~/.changrc" >> ~/.bash_profile
fi

if [ -f ~/.zshrc ] && ! grep -c "source ~/.changrc" ~/.zshrc >/dev/null; then
  echo "source ~/.changrc" >> ~/.zshrc
fi
