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

[[ -s /etc/bash_completion ]] && source /etc/bash_completion

[[ -s /usr/local/share/bash-completion/bash_completion ]] && source /usr/local/share/bash-completion/bash_completion

if [ -e "$HOME/src/c/ssh-authsock-hack/ssh-authsock-hack.so" ]; then
    export LD_PRELOAD="$HOME/src/c/ssh-authsock-hack/ssh-authsock-hack.so":$LD_PRELOAD
fi

umask 0022

export PYTHONSTARTUP=~/.pyrc
export CLICOLOR=1

shopt -s histappend
shopt -s cmdhist
export HISTSIZE=10000
export HISTFILESIZE=90000
export HISTCONTROL=ignoreboth
export HISTIGNORE=cd:pwd:history:fg:bg:jobs:ls:df:du:top

case $OSTYPE in
    darwin*)
        export PATH=~/bin:/usr/local/share/python:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH
        alias ls='ls -F'
    ;;
    linux*)
        export PATH=~/bin:/usr/sbin:/sbin:$PATH

        if [ "x$SSH_AUTH_SOCK" == "x" ]; then
            export SSH_AUTH_SOCK=$HOME/.ssh-agent
        fi

        alias ls='ls -F --color'

        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        fi
    ;;
esac

alias gti=git
alias g=git
complete -F _git gti
complete -F _git g

[ -z "$(which vimpager)" ] || export PAGER=vimpager

if [ -d ~/.pyenv/bin ]; then
    export PATH=$HOME/.pyenv/bin:$PATH
    eval "$(pyenv init -)"
fi

export NVM_DIR=$HOME/.nvm
[[ -r $NVM_DIR/nvm.sh ]] && source $NVM_DIR/nvm.sh
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
[[ -z "$GOROOT" ]] || export GOBIN=$GOROOT/bin

export PATH=$HOME/.rvm/bin:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

complete -F _known_hosts nc curl wget socat

function vcs_info() {
    local s=
    s="$(svn info 2>/dev/null | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p')"
    if [[ -z $s ]] ; then
        s=$(__git_ps1 "git:%s")
    else
        s="svn:$s"
    fi
    [ -z "$s" ] || echo -n "$s"
}

function git-setup() {
    git config --global user.name "Pranay Kanwar"
    git config --global user.email "pranay.kanwar@gmail.com"
}

function git-update-submodules() {
    git submodule init && git submodule update
    for M in $(git submodule  --quiet foreach 'echo $name') ; do
        git config submodule.$M.ignore untracked
    done
}

function puppet-check-syntax() {
    [ $# -eq 0 ] && return
    puppet parser validate $*
}

function rm-pyc() {
    find . -type f -name '*.pyc'  -print0 | xargs -0 rm -fv
}

function my-procs() {
    ps -o pid,ppid,nice,tty,start,%cpu,time,%mem,vsz,rss,stat,wchan,comm -U $USER
}

case $TERM in
     screen*|ansi*|xterm*|rxvt*)

        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWUPSTREAM="auto"
        export GIT_PS1_SHOWSTASHSTATE=1
        export GIT_PS1_SHOWUNTRACKEDFILES=1

        R="\033[0;00m"
        S="\033[1;31m"
        T="\033[0;33m"
        V="\033[0;34m\033[47m"
        F="\033[0;31m\033[47m"

        export PS1="\[${R}\]\[${F}\]\${?##0}\[${R}\]\[${V}\]\$(vcs_info)\[${R}\]\[${S}\]‣\[${R}\] "
        export PS2="   \[${T}\]‣\[${R}\] "
        export PS3=${PS2}
        export PS4=${PS2}

        function prompt_cmd() {
            echo -ne "\033]0;${USER}@${HOSTNAME%%.*}\007"
            history -a &> /dev/null
        }

        export PROMPT_COMMAND=prompt_cmd
     ;;
esac

shopt -s nullglob
for E in ~/.env/*
do
    source $E
done
shopt -u nullglob
