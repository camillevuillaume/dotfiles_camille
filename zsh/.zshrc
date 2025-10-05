export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export HOSTNAME=$HOST


autoload -Uz compinit
compinit

if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "ubuntu" ]]; then
        # Ubuntu specific settings
        export ZSH="$HOME/.oh-my-zsh"
        ZSH_THEME="gnzh"
        plugins=(git)
        source $ZSH/oh-my-zsh.sh

    elif [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
        # Arch specific settings
        #
        source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        source <(fzf --zsh)
        zstyle ':completion:*' menu select
        zstyle ':completion::complete:*' gain-privileges 1

        # Run starship if installed
        [ -x "$(command -v starship)" ] &&
        eval "$(starship init zsh)"

        alias pacfzf="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
        alias yayfzf="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro sudo yay -S"

        alias ssh='TERM="xterm-256color" kitty +kitten ssh'

        fastfetch --logo .config/fastfetch/arch.gif --logo-type kitty-direct --logo-animate true --logo-width 20

        function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
          yazi "$@" --cwd-file="$tmp"
          IFS= read -r -d '' cwd < "$tmp"
          [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
          rm -f -- "$tmp"
        }       
    fi
fi

alias grep='grep --color=auto'
[ -x "$(command -v eza)" ] &&
alias ls="eza --long --git --icons --hyperlink"

bindkey -v
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey '^[[3~' delete-char


