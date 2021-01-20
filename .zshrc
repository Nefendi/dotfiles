ZSH="/Users/nefendi/.zplug/repos/robbyrussell/oh-my-zsh"

ZSH_THEME="kphoen"

ENABLE_CORRECTION="true"

EDITOR="nvim"

plugins=(
    gitfast
    osx
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
)

source $ZSH/oh-my-zsh.sh

PATH="/usr/local/texlive/2018/bin/x86_64-darwin:/Users/nefendi/anaconda3/envs:/Users/nefendi/.local/bin:$PATH"

PERL5LIB="/Users/nefendi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL5LIB
PERL_LOCAL_LIB_ROOT="/Users/nefendi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_LOCAL_LIB_ROOT
PERL_MB_OPT="--install_base \"/Users/nefendi/perl5\""
export PERL_MB_OPT
PERL_MM_OPT="INSTALL_BASE=/Users/nefendi/perl5"
export PERL_MM_OPT


PROMPT='[%*]%{$reset_color%} [%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)]
%F{244}λ %{$reset_color%}'

GIT_PS1_SHOWSTASHSTATE=1

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo{+} | pbcopy)'"

############################################################################################################################3

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/nefendi/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/nefendi/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/nefendi/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/nefendi/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done <~/.zsh_nocorrect
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "/Users/nefendi/.ghcup/env" ] && source "/Users/nefendi/.ghcup/env" # ghcup-env
