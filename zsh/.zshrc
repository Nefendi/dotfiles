# ENVIRONMENT VARIABLES
export ZSH="$HOME"/.oh-my-zsh
export BUN_INSTALL="$HOME/.bun"

PATH="$HOME/antibody:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$BUN_INSTALL/bin:$PATH"

export EDITOR="nvim"

export MANPAGER="nvim +Man!"

FZF_DEFAULT_OPTS="--no-mouse --height 75% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window right:hidden:wrap --bind='ctrl-/:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-\\:change-preview-window(down|right)'"
# Tokyonight Night theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,hl:#ff9e64 \
--color=fg+:#c0caf5,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --no-ignore'

export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview-window nohidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_ALT_C_OPTS="--select-1 --exit-0 --preview 'tree -C {}' --preview-window nohidden"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --no-ignore"

export DOTNET_CLI_TELEMETRY_OPTOUT="true"

export ASDF_DATA_DIR="$HOME/.asdf"

PATH="$ASDF_DATA_DIR/shims:$PATH"

export PATH

# YOU-SHOULD-USE
# Source: https://github.com/MichaelAquilina/zsh-you-should-use/blob/master/you-should-use.plugin.zsh
export YSU_MESSAGE_FORMAT="$(tput bold)$(tput setaf 3)\
Found existing %alias_type for $(tput setaf 5)\"%command\"$(tput setaf 3). \
You should use: $(tput setaf 5)\"%alias\"$(tput sgr0)"

# ANTIDOTE
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

antidote load

# GOLANG
source "$HOME/.asdf/plugins/golang/set-env.zsh"

# BINDKEYS
bindkey '^ ' autosuggest-accept  # for accepting zsh-autosuggestions
bindkey '^x^e' edit-command-line # edit commands in editor

# COMPLETIONS
fpath+=~/.local/share/zsh/site-functions/

autoload -Uz compinit && compinit

# UV
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# BUN
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ALIASES
alias watch='watch '
alias ls='eza -gF --color=always --group-directories-first --icons'
alias ll='eza -glhF --color=always --group-directories-first --icons'
alias la='eza -galhF --color=always --group-directories-first --icons'
alias lt='eza -gaThF --color=always --group-directories-first --icons'
alias g='lazygit'
alias k='kubectl'
alias pip='noglob pip'
alias uv='noglob uv'
# alias poetry='noglob poetry'

alias updatesystem='sudo nala upgrade && sudo snap refresh && flatpak update'
alias updatetools='
    uv self update &&
    antidote update &&
    rustup self update && rustup update && rm -f ~/.cargo/bin/rust-analyzer &&
    cargo install-update -a &&
    asdf plugin update --all &&
    bun upgrade &&
    tldr --update &&
    (cd ~/.fzf && git pull && ./install --no-bash --no-fish --key-bindings --completion --no-update-rc)'
alias updateall='updatesystem && updatetools'

# STARSHIP
eval "$(starship init zsh)"
