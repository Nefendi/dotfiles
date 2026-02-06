# ENVIRONMENT VARIABLES
PATH="$HOME/antibody:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"

export EDITOR="nvim"

export MANPAGER="nvim +Man!"

# Start tmux every time unless there is a session running
export ZSH_TMUX_AUTOSTART=false
# Do not close the terminal after the session has been killed
export ZSH_TMUX_AUTOQUIT=false

FZF_DEFAULT_OPTS="--no-mouse --height 75% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window right:hidden:wrap --bind='ctrl-/:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-\\:change-preview-window(down|right)'"
# Tokyonight Night theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#283457 \
  # Transparency
  # --color=bg:-1 \
  --color=bg:#1a1b26 \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --no-ignore'

export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview-window nohidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_ALT_C_OPTS="--select-1 --exit-0 --preview 'tree -C {}' --preview-window nohidden"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --no-ignore"

export DOTNET_CLI_TELEMETRY_OPTOUT="true"

export PATH

# OPTIONS
setopt extendedglob
setopt dotglob
setopt correct

# ANTIDOTE
source '/usr/share/zsh-antidote/antidote.zsh'

antidote load

zstyle ':fzf-tab:*' use-fzf-default-opts yes

# GOLANG
source "$HOME/.asdf/plugins/golang/set-env.zsh"

# BINDKEYS
bindkey '^ ' autosuggest-accept  # for accepting zsh-autosuggestions
bindkey '^x^e' edit-command-line # edit commands in editor
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

# COMPLETIONS
fpath+=~/.local/share/zsh/site-functions/

autoload -Uz compinit && compinit

# YAZI
unalias y
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# ALIASES
alias ls='eza'
alias ll='ls -glbhF --group-directories-first --icons --git --octal-permissions'
alias l='ll'
alias la='ll -a'
alias g='lazygit'
alias task='go-task'

alias watch='watch '

alias -g RG='| rg'

alias n='nvim'

alias updatesystem='paru -Syu'
alias updatetools='
    uv tool upgrade --all
    antidote update
    rustup self update && rustup update && rm -f ~/.cargo/bin/rust-analyzer
    cargo install-update -a
    asdf plugin update --all
    tldr --update
'
alias updateall='
    updatesystem
    updatetools
'
