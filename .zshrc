ZSH="/Users/nefendi/.zplug/repos/robbyrussell/oh-my-zsh"

ZSH_THEME="candy"

ENABLE_CORRECTION="true"

plugins=(
  gitfast
  hacker-quotes
  osx
  colored-man-pages
  sudo
  cargo
  python
  pep8
  pip
)

ZSH_HACKER_QUOTES_ENABLE_WHEN_INTERACTIVE="1"

source $ZSH/oh-my-zsh.sh
source /Users/nefendi/.oh-my-zsh/custom/plugins/hacker-quotes/hacker-quotes.plugin.zsh

PATH="/usr/local/texlive/2018/bin/x86_64-darwin:/Users/nefendi/anaconda3/envs:/usr/local/opt/llvm/bin:/Users/nefendi/.local/bin:$PATH"

if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done < ~/.zsh_nocorrect
fi

PERL5LIB="/Users/nefendi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/nefendi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/nefendi/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/nefendi/perl5"; export PERL_MM_OPT;

export CPLUS_INCLUDE_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/nefendi/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

fpath+=${ZDOTDIR:-~}/.zsh_functions
