#!/bin/bash

[ -z "$PS1" ] && return

#load home brew and bash completion first
# shellcheck source=/dev/null
source "$HOME/.bash/aa_brew"
# shellcheck source=/dev/null
source "$HOME/.bash/completion"

if [ -f /etc/profile ];then
    #shellcheck disable=SC1091
    . /etc/profile
fi

umask 0022

shopt -s nullglob
for B in ~/.bash/*
do
    if [ -x "$B" ]; then
      # shellcheck source=/dev/null
      source "$B"
    fi
done
shopt -u nullglob
export VOLTA_HOME="/Users/pkanwar/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
