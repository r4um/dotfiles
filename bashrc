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

if [ -e "$HOME/src/c/misc/ssh-agent-hack.so" ]; then
    export LD_PRELOAD="$HOME/src/c/misc/ssh-agent-hack.so":$LD_PRELOAD
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
export DEBFULLNAME="Pranay Kanwar"
export DEBEMAIL="pranay.kanwar@gmail.com"
export GIT_EDITOR=/usr/bin/vim

shopt -s histappend
export HISTSIZE=10000
export HISTFILESIZE=90000

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
    ;;
    linux*)
        export PATH=~/bin:/usr/sbin:/sbin:$PATH
        if [ "x$SSH_AUTH_SOCK" == "x" ]; then
            export SSH_AUTH_SOCK=$HOME/.ssh-agent
        fi
    ;;
esac

[ -z "$(which vimpager)" ] || export PAGER=vimpager

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

PATH=$PATH:$HOME/.rvm/bin

[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"

export NVM_DIR=$HOME/.nvm
[[ -r $NVM_DIR/nvm.sh ]] && source $NVM_DIR/nvm.sh
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

complete -F _known_hosts nc curl wget socat

if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
fi

function vcs_info() {
    local s=
    if [[ -d ".svn" ]] ; then
        s="svn:$(svn info | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p')"
    else
        s=$(__git_ps1 "git:%s")
    fi
    [ -z "$s" ] || echo -n "($s)"
}

function github-setup() {
    git config --global user.name "Pranay Kanwar"
    git config --global user.email "pranay.kanwar@gmail.com"
    git config --global github.user "r4um"
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
    ps -u $USER -o pid,ppid,nice,tty,start,%cpu,time,%mem,vsz,rss,stat,wchan,comm
}

case $TERM in
     screen*|ansi*|xterm*|rxvt*)
        S="\[\e[31m\]\[\e[40m\]"
        E="\]\e[m\]"
        P="\]\e[m\]\[\e[30m\]─\[\e[m\]"
        N="\n\[\e[31m\]»\[\e[m\] "
        X="$P$S"
        RP="\$(~/.rvm/bin/rvm-prompt)"
        SI="\$(vcs_info)"
        PS1="$S \u@\h $X \$? $X $SI \w $X $RP $E$N"
        PS2="\[\e[32m\]»\[\e[m\] "
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~} $(vcs_info)\007"'
     ;;
esac


