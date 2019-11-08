#!/bin/bash

[ -z "$PS1" ] && return

if [ -f /etc/profile ];then
    #shellcheck disable=SC1091
    . /etc/profile
fi

umask 0022

shopt -s nullglob
for B in ~/.bash/*
do
    # shellcheck source=/dev/null
    source "$B"
done
shopt -u nullglob
