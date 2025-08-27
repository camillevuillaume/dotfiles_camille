export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx


autoload -Uz compinit
compinit

source <(fzf --zsh)
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

eval "$(starship init zsh)"

alias pacfzf="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias yayfzf="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro sudo yay -S"
#alias yayfzf="yay -Slq | fzf -q "$1" --preview 'yay -Si {1}'| xargs -ro yay -S"
alias grep='grep --color=auto'
alias ls="eza --long --git --icons --hyperlink"

fastfetch --logo .config/fastfetch/arch.gif --logo-type kitty-direct --logo-animate true --logo-width 22

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
