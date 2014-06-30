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
export HISTSIZE=10000
export HISTFILESIZE=90000

case $OSTYPE in
    darwin*)
        export PATH=~/bin:/usr/local/share/python:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH
    ;;
    linux*)
        export PATH=~/bin:/usr/sbin:/sbin:$PATH
        if [ "x$SSH_AUTH_SOCK" == "x" ]; then
            export SSH_AUTH_SOCK=$HOME/.ssh-agent
        fi
    ;;
esac

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

if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
fi

function vcs_info() {
    local s=
    if [[ -d ".svn" ]] ; then
        s="svn:$(svn info | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p') "
    else
        s=$(__git_ps1 "git:%s")
    fi
    [ -z "$s" ] || echo -n "$s"
}

function python_info() {
    PP=$(pyenv version)
    PP=${PP//$HOME/\~}
    PP=${PP//set by /}
    if [ ! -z $VIRTUAL_ENV ]; then
        PP="@$(basename $VIRTUAL_ENV) $PP"
    fi
    echo -n $PP
}

function git-setup() {
    git config --global user.name "Pranay Kanwar"
    git config --global user.email "pranay.kanwar@gmail.com"
    git config --global color.ui auto
    git config --global core.pager cat
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

        S="\033[0;36m"
        R="\033[0;00m"
        export PS1="\[${R}\]\[${S}\]λ\[${R}\]: "
        export PS2="   \[${S}\]>\[${R}\]: "
        export PS3=${PS2}
        export PS4=${PS2}

        function prompt_cmd() {
            echo -ne "\033]0;[${USER}@${HOSTNAME%%.*}][$?][${PWD/#$HOME/~}][$(vcs_info)][$(~/.rvm/bin/rvm-prompt)]\007"
        }

        export PROMPT_COMMAND=prompt_cmd
     ;;
esac
