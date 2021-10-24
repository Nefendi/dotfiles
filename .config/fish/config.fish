# ENVIRONMENT VARIABLES
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/miniconda3/envs $PATH
set -gx PATH $HOME/.emacs.d/bin $PATH
set -gx PATH $HOME/.poetry/bin $PATH
set -gx PATH $HOME/.fzf/bin $PATH
set -gx PATH /usr/local/go/bin $PATH
set -gx PATH $HOME/go/bin $PATH

set fish_greeting ""
set -gx TERM xterm-256color
set -gx EDITOR lvim
set -gx fish_escape_delay_ms 500

# FZF
# set -gx FZF_LEGACY_KEYBINDINGS 0

# set -gx FZF_COMPLETE 1

set -gx FZF_DEFAULT_OPTS "--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | xclip)'"

set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow --no-ignore-vcs"

set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# ALIASES
alias k "kubectl"
alias ls "exa -g --color=always --group-directories-first --icons"
alias ll "exa -gl --color=always --group-directories-first --icons"
alias la "exa -gal --color=always --group-directories-first --icons"
alias lt "exa -gaT --color=always --group-directories-first --icons"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# GHCUP
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# TMUX
if status --is-interactive && not set -q TMUX
  tmux new-session -As main
end

# Tokyonight Storm color palette
# Upstream: https://github.com/folke/tokyonight.nvim/blob/main/extras/fish_tokyonight_storm.fish
set -l foreground c0caf5
set -l selection 364A82
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

# STARSHIP
starship init fish | source


