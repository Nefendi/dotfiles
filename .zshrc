# ENVIRONMENT VARIABLES
export ZSH="${HOME}"/.oh-my-zsh
export PATH="${HOME}/antibody:${HOME}/.local/bin:${HOME}/miniconda3/envs:${PATH}"

export EDITOR="nvim"

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | xclip)'"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

# ANTIBODY
source "${HOME}"/.zsh_plugins.sh

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

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# STARSHIP
eval "$(starship init zsh)"
