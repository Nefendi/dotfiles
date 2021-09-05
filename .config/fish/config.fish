# ENVIRONMENT VARIABLES
set -e fish_user_paths
set -gx fish_user_paths $HOME/.local/bin $HOME/miniconda3/envs $HOME/.emacs.d/bin $HOME/.poetry/bin $HOME/.fzf/bin $fish_user_paths

set -gx fish_greeting
set -gx TERM "xterm-256color"
set -gx EDITOR "nvim"
set -gx fish_escape_delay_ms 500

set -gx FZF_LEGACY_KEYBINDINGS 0

set -gx FZF_COMPLETE 1

# set -gx FZF_DEFAULT_OPTS "--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | xclip)'"

set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow --no-ignore-vcs"

set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# AUTOCOMPLETE AND HIGHLIGHT COLORS
# set -gx fish_color_normal brcyan
# set -gx fish_color_autosuggestion '#7d7d7d'
# set -gx fish_color_command brcyan
# set -gx fish_color_error '#ff6c6b'
# set -gx fish_color_param brcyan

# ALIASES
alias k="kubectl"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# GHCUP
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# STARSHIP
starship init fish | source


