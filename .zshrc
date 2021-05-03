# PATHS
export ZSH="${HOME}/.oh-my-zsh"
export PATH="${HOME}/.local/bin:${HOME}/miniconda3/envs:${PATH}"

# ZSH_CONFIGURATION
EDITOR="nvim"
ENABLE_CORRECTION="true"
ZSH_GIT_PROMPT_SHOW_UPSTREAM="full"
ZSH_GIT_PROMPT_SHOW_STASH=1

# ANTIGEN
source "${HOME}/antigen/antigen.zsh"
antigen init "${HOME}/.antigenrc"

# OTHER_SETTINGS
FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | xclip)'"

PROMPT='[%*]%{$reset_color%} [%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(gitprompt)]
%F{244}λ %{$reset_color%}'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("${HOME}"'/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/${HOME}/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# GHCUP
[ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env"

# ZSH_NOCORRECT
if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done <~/.zsh_nocorrect
fi
