#!/bin/bash

[ -z "$PS1" ] && return

if [ -f /etc/profile ];then
    . /etc/profile
fi

if [ -e /usr/local/bin/brew ]; then
    BREW_PREFIX=$(brew --prefix)
    if [ -f $BREW_PREFIX/etc/bash_completion ]; then
        . $BREW_PREFIX/etc/bash_completion
    fi
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

export PYTHONSTARTUP=~/.pystartup
export GREP_COLOR=00\;35
export XAUTHORITY=/home/cpk/.Xauthority
export PAGER=vimpager
export VISUAL=vim
export CLICOLOR=1

shopt -s histappend

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

case $OSTYPE in
    darwin*)
        export GEM_HOME=$HOME/Source/Ruby/Gems
        export GEM_PATH=$HOME/Source/Ruby/Gems/1.8:/Library/Ruby/Gems/1.8
        export PATH=~/Bin:/usr/local/share/python:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$HOME/Source/Ruby/Gems/bin:$PATH
        export CDPATH=~/Source
    ;;
    linux*)
        export CDPATH=~/src
        export PATH=~/bin:/usr/sbin:/sbin:$PATH
    ;;
esac

case $TERM in
     ansi*|xterm*|rxvt*)
        PS1="\[\e[37m\]\[\e[44m\] \u@\h \]\e[m\]\[\e[34m\]─\[\e[37m\]\[\e[44m\] \$? \]\e[m\]\[\e[34m\]─\[\e[m\]\[\e[37m\]\[\e[44m\] \w \]\e[m\]\e[m\]\n\[\e[34m\]»\[\e[m\] "
        PS2="\[\e[33m\]»\[\e[m\] "
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
     ;;
esac
