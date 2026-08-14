# .bashrc

# Keep non-interactive shells free of aliases, prompts, and terminal setup.
[[ $- != *i* ]] && return

export EDITOR=nvim
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"

# Shared file-type colors for GNU ls and lsd.
export LS_COLORS="di=36:ln=35:ex=32:pi=33:so=35:bd=33:cd=33:or=31:mi=31"

# Append history instead of overwriting it and share new commands between shells.
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend

# Build the prompt after saving the real exit status of the previous command.
# The old command substitution displayed only 0 or 1, not the actual status.
__prompt_command() {
  local status=$? status_color

  history -a
  history -n

  if (( status == 0 )); then
    status_color='\[\e[32m\]'
  else
    status_color='\[\e[31m\]'
  fi

  PS1='\[\e[38;5;208m\]\u\[\e[0m\] \[\e[37m\]{  \w }\[\e[0m\] '
  PS1+="${status_color}${status}"
  PS1+='\[\e[0m\]\n\[\e[35m\]\[\e[0m\] '
}
PROMPT_COMMAND=__prompt_command

alias ls='ls --color=auto'
alias grep='grep --color=auto'

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

fcd() {
  local dir
  dir=$(FZF_DEFAULT_COMMAND="fd . ~ --no-ignore --type d 2>/dev/null" fzf) \
    && [[ -n $dir ]] \
    && builtin cd -- "$dir"
}

# Change to the directory Yazi exits from.
y() {
  local tmp cwd
  tmp=$(mktemp -t yazi-cwd.XXXXXX) || return
  yazi "$@" --cwd-file="$tmp"
  if cwd=$(command cat -- "$tmp") && [[ -n $cwd && $cwd != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

set -o vi

# Keep multiline pastes together instead of feeding later lines to commands
# such as an interactive password prompt.
bind 'set enable-bracketed-paste on'

# Let terminal pinentry use the current TTY when GnuPG is available.
if [[ -t 1 ]] && command -v gpg-connect-agent >/dev/null 2>&1; then
  export GPG_TTY="$(tty)"
  export PINENTRY_USER_DATA=tty
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1 || true
fi

# Prefix-based history search.
bind -m vi-command '"k": history-search-backward'
bind -m vi-command '"j": history-search-forward'
bind -m vi-insert '"\e[A": history-search-backward'
bind -m vi-insert '"\e[B": history-search-forward'
