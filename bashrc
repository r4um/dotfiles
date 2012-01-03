#!/bin/bash

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

if [ -f /etc/profile ];then
    . /etc/profile
fi

if [ -f /etc/bash_completion ];then
    . /etc/bash_completion
fi

umask 0022

alias shred='shred -u -f -v'
alias mount='mount -v'
alias umount='umount -v'
alias ipcalc='ipcalc.pl -n'
alias vi='vim'
alias gdb='gdb -q'
alias grep='grep --color=auto'

export PYTHONSTARTUP=~/.pystartup
export GREP_COLOR=00\;35
export XAUTHORITY=/home/cpk/.Xauthority
export PAGER=vimpager
export VISUAL=vim
export CLICOLOR=1

shopt -s histappend

case $OSTYPE in
    darwin*)
        export GEM_HOME=$HOME/Source/Ruby/Gems
        export GEM_PATH=$HOME/Source/Ruby/Gems/1.8:/Library/Ruby/Gems/1.8
        export PATH=~/Bin:/usr/local/share/python:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$HOME/Source/Ruby/Gems/bin:$PATH
        export CDPATH=~/Source
    ;;
esac

case $TERM in
     ansi*|xterm*|rxvt*)
        PS1="\[\e[37m\]\[\e[44m\] \$? \]\e[m\]\[\e[34m\]─\[\e[m\]\[\e[37m\]\[\e[44m\] \w \]\e[m\]\e[m\]\n\[\e[34m\]»\[\e[m\] "
        PS2="\[\e[33m\]»\[\e[m\] "
     ;;
esac
