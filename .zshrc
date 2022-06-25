# ENVIRONMENT VARIABLES
export ZSH="${HOME}"/.oh-my-zsh
export PATH="${HOME}/antibody:${HOME}/.local/bin:${HOME}/.emacs.d/bin:${HOME}/.poetry/bin:/usr/local/go/bin:${HOME}/go/bin:${PATH}"

export EDITOR="nvim"

export TERM="xterm-256color"

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | xclip)'"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

# NVM
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('lvim' 'nvim')

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

# STARSHIP
eval "$(starship init zsh)"
