export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

autoload -Uz compinit
compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

eval "$(starship init zsh)"

alias pacfzf="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias grep='grep --color=auto'
alias ls="eza --long --git --icons --hyperlink"
