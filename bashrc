#!/bin/bash

[ -z "$PS1" ] && return

if [ -f /etc/profile ];then
    . /etc/profile
fi

umask 0022

shopt -s nullglob
for B in ~/.bash/*
do
    source $B
done
shopt -u nullglob
