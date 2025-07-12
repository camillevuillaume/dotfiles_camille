#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

eval "$(fzf --bash)"
eval "$(starship init bash)"

alias pacfzf="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias grep='grep --color=auto'
alias ls="eza --long --git --icons --hyperlink"
