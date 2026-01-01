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

eval "$(zoxide init zsh)"

# Auto-activate Python venv on directory change
auto_venv() {
  # Check if we're in a Python project (has requirements.txt or pyproject.toml)
  if [[ -f "pyproject.toml" ]]; then
    local venv_dir=".venv"
    
    # Create venv if it doesn't exist
    if [[ ! -d "$venv_dir" ]]; then
      python3 -m venv "$venv_dir"
      
      if [[ -f "pyproject.toml" ]]; then
        echo "Installing from pyproject.toml..."
        "$venv_dir/bin/pip" install -e .
      fi
    fi
    
    # Activate venv if not already activated
    if [[ "$VIRTUAL_ENV" != "$PWD/$venv_dir" ]]; then
      source "$venv_dir/bin/activate"
      echo "Activated venv: $venv_dir"
    fi
  else
    # Deactivate venv if we left a Python project directory
    if [[ -n "$VIRTUAL_ENV" ]]; then
      deactivate
      echo "Deactivated venv"
    fi
  fi
}

# Register the hook
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_venv

# Run once on shell start
auto_venv

