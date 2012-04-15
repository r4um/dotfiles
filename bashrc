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

export PYTHONSTARTUP=~/.pyrc
export GREP_COLOR=00\;35
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
        export PATH=~/Bin:/usr/local/share/python:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH
        export CDPATH=~/Source
    ;;
    linux*)
        export CDPATH=~/src
        export PATH=~/bin:/usr/sbin:/sbin:$PATH
        if [ "x$SSH_AUTH_SOCK" == "x" ]; then
            export SSH_AUTH_SOCK=$HOME/.ssh-agent
        fi
    ;;
esac

case $TERM in
     screen*|ansi*|xterm*|rxvt*)
        PS1="\[\e[31m\]\[\e[40m\] \u@\h \]\e[m\]\[\e[30m\]─\[\e[31m\]\[\e[40m\] \$? \]\e[m\]\[\e[30m\]─\[\e[m\]\[\e[31m\]\[\e[40m\] \w \]\e[m\]\e[m\]\n\[\e[31m\]»\[\e[m\] "
        PS2="\[\e[31m\]»\[\e[m\] "
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
     ;;
esac

[ -z "$(which vimpager)" ] || export PAGER=vimpager

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin

complete -F _known_hosts nc

function github-setup() {
    [ -z $1 ] && echo "No token provided" && return
    git config --global user.name "Pranay Kanwar"
    git config --global user.email "pranay.kanwar@gmail.com"
    git config --global github.user "r4um"
    git config --global github.token $1
}

function git-update-submodules() {
    git submodule init && git submodule update
}

function puppet-check-syntax() {
    [ $# -eq 0 ] && return
    puppet parser validate $*
}

function rm-pyc() {
    find . -type f -name '*.pyc'  -print0 | xargs -0 rm -fv
}

function my-procs() {
    ps -a -u $USER -o pid,ppid,nice,tty,start,%cpu,time,%mem,vsz,rss,stat,wchan,cmd --sort vsz
}

