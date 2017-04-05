#!/usr/bin/env zsh

# ------------------------------------------------
# Алиасы

alias se='sudoedit'
alias e='$EDITOR'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ------------------------------------------------
# Глобальные алиасы (замена осуществляется
# в любом месте командной строки)

alias -g L='| less'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'

# ------------------------------------------------
# Python

export PYTHONSTARTUP=~/.python-startup.py

