export ZSH="/home/nefendi/.oh-my-zsh"

ZSH_THEME="kphoen"

ENABLE_CORRECTION="true"

EDITOR="nvim"

plugins=(
    gitfast
    common-aliases
    colored-man-pages
    sudo
    cargo
    python
    pep8
    pylint
    pip
    z
    copyfile
    docker
    encode64
    extract
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf
)

source $ZSH/oh-my-zsh.sh

PATH="/home/nefendi/.local/bin:/home/nefendi/miniconda3/envs:$PATH"

PROMPT='[%*]%{$reset_color%} [%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)]
%F{244}λ %{$reset_color%}'

GIT_PS1_SHOWSTASHSTATE=1

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | xclip)'"

#############################################################################################################################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nefendi/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nefendi/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/nefendi/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/nefendi/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f "/home/nefendi/.ghcup/env" ] && source "/home/nefendi/.ghcup/env" # ghcup-env

if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done <~/.zsh_nocorrect
fi
