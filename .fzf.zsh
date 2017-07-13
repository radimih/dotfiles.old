# Setup fzf
# ---------
if [[ ! "$PATH" == */home/radimir/.fzf/bin* ]]; then
  export PATH="$PATH:/home/radimir/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/radimir/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/radimir/.fzf/shell/key-bindings.zsh"

