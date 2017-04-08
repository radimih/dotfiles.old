#!/usr/bin/env zsh

# ------------------------------------------------
# Алиасы

alias ll='ls -AlF --group-directories-first'
alias la='ls -A --group-directories-first'
alias df='df -h'
alias du='du -h'
alias e='$EDITOR'
alias se='sudoedit'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ------------------------------------------------
# Глобальные алиасы (замена осуществляется
# в любом месте командной строки)

alias -g L='| less'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'

# ------------------------------------------------
# История команд

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

setopt append_history
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
#??? setopt share_history

# ------------------------------------------------
# Прочие параметры оболочки

setopt auto_cd
setopt correct
setopt no_beep
setopt ignore_eof
setopt prompt_subst
setopt interactive_comments

# ------------------------------------------------
# oh-my-zsh

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

ZSH_THEME="blinks"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ------------------------------------------------
# Python

export PYTHONSTARTUP=~/.python-startup.py

