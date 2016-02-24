#!/bin/bash

CHANG_DIR=/Users/majkel/chang
CHANG_PROJECTS_DIR=$CHANG_DIR/projects

function _chang_projects_completion() {
  COMPREPLY=($(compgen -W "$(chang_projects_list)" -- ${1}))
}

function _chang_project_completion() {
  _chang_bindir_completion "${CHANG_PROJECTS_DIR}/${1}/.chang/bin"
}

function _chang_bindir_completion() {
  local bindir=$1
  shift

  local commands=${COMP_WORDS[@]:1:$(( COMP_CWORD > 0 ? COMP_CWORD - 1 : 0 ))}
  local current=${COMP_WORDS[COMP_CWORD]}

  local script="${bindir}"
  local command
  for command in ${commands[@]}; do
    script="${script}/${command}"
  done
  COMPREPLY=()

  if [[ -d $script ]]; then
    local executables=($(find ${script} -perm +111 -type f -or -type l))
    local completions=(${executables[@]#$script/})
    local del=($command)
    local completions=(${completions[@]%%/*})
    COMPREPLY=($(compgen -W "${completions[*]/$del}" -- ${current}))
  fi
}

function _chang-run_completion() {
  local project=${COMP_WORDS[1]}

  if [[ $COMP_CWORD -gt 1 ]]; then
    COMP_WORDS=(${COMP_WORDS[@]:1})
    COMP_CWORD=$((COMP_CWORD > 0 ? COMP_CWORD - 1 : 0))
    _chang_project_completion $project
  else
    _chang_projects_completion $project
  fi
}

function chang_projects_list() {
  local projects=($(find $CHANG_PROJECTS_DIR -type d -mindepth 1 -maxdepth 1))
  echo ${projects[@]#$CHANG_PROJECTS_DIR/}
}

complete -F _chang-run_completion chang-run
for project in `chang_projects_list`; do
	alias $project="chang-run $project"
	complete -F _chang_project_completion $project
done
