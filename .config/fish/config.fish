# ENVIRONMENT VARIABLES
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/miniconda3/envs $PATH
set -gx PATH $HOME/.emacs.d/bin $PATH
set -gx PATH $HOME/.poetry/bin $PATH
set -gx PATH $HOME/.fzf/bin $PATH

set fish_greeting ""
set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx fish_escape_delay_ms 500

set -gx FZF_LEGACY_KEYBINDINGS 0

set -gx FZF_COMPLETE 1

# set -gx FZF_DEFAULT_OPTS "--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | xclip)'"

set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow --no-ignore-vcs"

set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# ALIASES
alias k "kubectl"
alias ll "exa -l -g --icons"
alias lla "ll -a"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# GHCUP
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# STARSHIP
starship init fish | source


