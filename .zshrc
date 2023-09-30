# ENVIRONMENT VARIABLES
export ZSH="$HOME"/.oh-my-zsh

PATH="$HOME/antibody:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.emacs.d/bin:$PATH"
PATH="$HOME/.poetry/bin:$PATH"
PATH="/usr/local/go/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.erg/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"

export PATH

export EDITOR="nvim"

export MANPAGER="nvim +Man!"

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | xclip)'"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export DOTNET_CLI_TELEMETRY_OPTOUT="true"

# FNM
export ZSH_FNM_ENV_EXTRA_ARGS="--use-on-cd"
export ZSH_FNM_NODE_VERSION="18.17.0"

# ERG
export ERG_PATH="$HOME/.erg"

# YOU-SHOULD-USE
# Source: https://github.com/MichaelAquilina/zsh-you-should-use/blob/master/you-should-use.plugin.zsh
export YSU_MESSAGE_FORMAT="$(tput bold)$(tput setaf 3)\
Found existing %alias_type for $(tput setaf 5)\"%command\"$(tput setaf 3). \
You should use: $(tput setaf 5)\"%alias\"$(tput sgr0)"

# ANTIDOTE
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

antidote load

# BINDKEYS
bindkey '^ ' autosuggest-accept # for accepting zsh-autosuggestions

# COMPLETIONS
autoload -U compinit
compinit

# ALIASES
alias ls='exa -gF --color=always --group-directories-first --icons'
alias ll='exa -glFh --color=always --group-directories-first --icons'
alias la='exa -galFh --color=always --group-directories-first --icons'
alias lt='exa -gaTFh --color=always --group-directories-first --icons'
alias n='nordvpn'
alias g='lazygit'
alias bat='batcat'
alias k='kubectl'
alias tldr='tldr -t base16'
alias pip='noglob pip'
alias poetry='noglob poetry'

# alias updatesystem='sudo apt update && sudo apt upgrade && sudo snap refresh && flatpak update'
alias updatesystem='sudo nala upgrade && sudo snap refresh && flatpak update'
alias updatetools='
    poetry self update &&
    antidote update &&
    pyenv update &&
    rustup self update && rustup update && rm -f ~/.cargo/bin/rust-analyzer &&
    cargo install-update -a'
alias updateall='updatesystem && updatetools'

# GHCUP
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# STARSHIP
eval "$(starship init zsh)"
