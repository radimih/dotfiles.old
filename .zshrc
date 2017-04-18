#!/usr/bin/env zsh

[ -d $HOME/bin ] && export PATH=$HOME/bin:$PATH

# ------------------------------------------------
# oh-my-zsh

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

ZSH_THEME="rkj-repos"
COMPLETION_WAITING_DOTS="true"

plugins=(zsh-syntax-highlighting zsh-autosuggestions git vi-mode colored-man-pages fancy-ctrl-z docker docker-compose)

source $ZSH/oh-my-zsh.sh

# ------------------------------------------------
# Алиасы

alias ll='ls -AlF --group-directories-first'
alias la='ls -A --group-directories-first'
alias df='df -h'
alias du='du -h'
alias e='$EDITOR'
alias se='sudoedit'
alias ping='ping -c4'
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
setopt extended_history
setopt inc_append_history_time
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space

# ------------------------------------------------
# Прочие параметры оболочки

setopt auto_cd
setopt correct
setopt no_beep
setopt ignore_eof
setopt prompt_subst
setopt interactive_comments

# ------------------------------------------------
# Текстовый редактор по-умолчанию

if which vim > /dev/null 2>&1
then
  export EDITOR=`which vim`
else
  export EDITOR=/usr/bin/vi
fi

# ------------------------------------------------
# Цветной вывод команды ls

if [[ "$TERM" != "dumb" ]]; then
  if [[ -x $(which dircolors) ]]; then
  eval $(dircolors -b)
  alias 'ls=ls --color=auto'
  fi
fi

# ------------------------------------------------
# Python

export PYTHONSTARTUP=~/.python-startup.py

