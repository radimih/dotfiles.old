#!/usr/bin/env zsh

[ -d $HOME/bin ] && export PATH=$HOME/bin:$PATH

# ------------------------------------------------
# oh-my-zsh

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

ZSH_THEME="rkj-repos"
COMPLETION_WAITING_DOTS="true"

plugins=(zsh-syntax-highlighting zsh-autosuggestions history-substring-search \
    deer git colored-man-pages fancy-ctrl-z docker docker-compose)

source $ZSH/oh-my-zsh.sh

# ------------------------------------------------
# Освободить для терминала комбинации клавиш
# Ctrl+С/V, вместо Ctrl+C сделать Ctrl+Q.
# Не забыть в настройках терминала назначить
# на клавиши Ctrl+C/V вставку/копирование.

stty lnext undef  # освободить Ctrl+V
stty start undef  # освободить Ctrl+Q
stty intr ^Q      # вместо Ctrl+C сделать Ctrl+Q

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
# Красный курсор

echo -ne "\e]12;red\a"

# ------------------------------------------------
# vi-mode для командой строки + форма курсора
# в зависимости от режима

bindkey -v
KEYTIMEOUT=5

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] \
    || [[ $KEYMAP = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() { zle-keymap-select 'beam'}

# ------------------------------------------------
# zsh-автодополнение (autosuggestions)

# Клавиша перехода на следующее слово
bindkey '`' forward-word

# ------------------------------------------------
# Ctrl-D: ranger-подобная навигация по файлам
# (https://github.com/Vifon/deer)

bindkey '^d' deer

# ------------------------------------------------
# Python

export PYTHONSTARTUP=~/.python-startup.py

# ------------------------------------------------
# fzf (обязательно после команды bindkey -v)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Выбирать файл по Ctrl-F вместо стандартного Ctrl-T
bindkey '^F' fzf-file-widget

# Опции утилиты fzf
export FZF_DEFAULT_OPTS='--border'

# -- Использовать утилиту ag вместо find, включить
#    в поиск скрытые файлы и игнорировать git-репы
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --silent -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

