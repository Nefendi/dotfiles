# ENVIRONMENT VARIABLES
export ZSH="${HOME}"/.oh-my-zsh
export PATH="${HOME}/antibody:${HOME}/.local/bin:${HOME}/.emacs.d/bin:${HOME}/.poetry/bin:/usr/local/go/bin:${HOME}/go/bin:${PATH}"

export EDITOR="nvim"

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | xclip)'"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

# FNM
export ZSH_FNM_ENV_EXTRA_ARGS="--use-on-cd"
export ZSH_FNM_NODE_VERSION="16.17.0"

# YOU-SHOULD-USE
# Source: https://github.com/MichaelAquilina/zsh-you-should-use/blob/master/you-should-use.plugin.zsh
export YSU_MESSAGE_FORMAT="$(tput bold)$(tput setaf 3)\
Found existing %alias_type for $(tput setaf 5)\"%command\"$(tput setaf 3). \
You should use: $(tput setaf 5)\"%alias\"$(tput sgr0)"

# ANTIBODY
source "${HOME}"/.zsh_plugins.sh

# BINDKEYS
bindkey '^ ' autosuggest-accept # for accepting zsh-autosuggestions

# ALIASES
alias ls='exa -gF --color=always --group-directories-first --icons'
alias ll='exa -glFh --color=always --group-directories-first --icons'
alias la='exa -galFh --color=always --group-directories-first --icons'
alias lt='exa -gaTFh --color=always --group-directories-first --icons'
alias n='nordvpn'
alias g='lazygit'

# GHCUP
[ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env"

# GVM
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

# STARSHIP
eval "$(starship init zsh)"
