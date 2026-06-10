# .bashrc

LS_COLORS="di=36:ln=35"
PS1='\[\e[38;5;208m\]\u\[\e[0m\] \[\e[37m\]{  \w }\[\e[0m\] $(if [ $? -eq 0 ]; then printf "\[\e[32m\]$?"; else printf "\[\e[31m\]$?"; fi)\[\e[0m\]\n\[\e[35m\]\[\e[0m\] '

# Bash history
# This ignores commands that start with space and removes from history any other occurences of the last command.
HISTCONTROL=ignorespace:erasedups
HISTSIZE=1000
HISTFILESIZE=1000
PROMPT_COMMAND="deduplicate_history" # This runs after every command entered in the terminal
deduplicate_history() {
  # Append last command to bash_history
  history -a

  # Remove duplicates from bash_history
  tac ~/.bash_history | awk '!seen[$0]++' | tac > /tmp/bashis.tmp && mv /tmp/bashis.tmp ~/.bash_history

  # Reload session bash history (clear and read from file)
  history -c
  history -r
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fcd='dir=$(FZF_DEFAULT_COMMAND="fd . ~ --no-ignore --type d 2>/dev/null" fzf) && cd "$dir"'
set -o vi

# Prefix based history search
bind -m vi-command '"k": history-search-backward'
bind -m vi-command '"j": history-search-forward'
bind -m vi-insert '"\e[A": history-search-backward'
bind -m vi-insert '"\e[B": history-search-forward'
